#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Feb 10 15:49:09 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.15-s110_1 (64bit) 09/23/2022 13:08 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.15-s110_1 NR220912-2004/21_15-UB (database version 18.20.592) {superthreading v2.17}
#@(#)CDS: AAE 21.15-s039 (64bit) 09/23/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.15-s038_1 () Sep 20 2022 11:42:13 ( )
#@(#)CDS: SYNTECH 21.15-s012_1 () Sep  5 2022 10:25:51 ( )
#@(#)CDS: CPE v21.15-s076
#@(#)CDS: IQuantus/TQuantus 21.1.1-s867 (64bit) Sun Jun 26 22:12:54 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

set design(TOPLEVEL) "lp_riscv_top"
set runtype "pnr"
set debug_file "debug.txt"
source ../scripts/procedures.tcl -quiet
enics_start_stage "start"
source ../inputs/$design(TOPLEVEL).defines -quiet
source $design(libraries_dir)/libraries.$TECHNOLOGY.tcl -quiet
source $design(libraries_dir)/libraries.$SC_TECHNOLOGY.tcl -quiet
source $design(libraries_dir)/libraries.$SRAM_TECHNOLOGY.tcl -quiet
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    source $design(libraries_dir)/libraries.$IO_TECHNOLOGY.tcl -quiet
}
set_library_unit -time 1ns -cap 1pf
set var_list {runtype}
set dic_list {paths tech tech_files design}
enics_print_debug_data w $debug_file "after everything was loaded" $var_list $dic_list
enable_metrics -on
enics_start_stage "init_design"
set_db init_ground_nets $design(all_ground_nets)
set_db init_power_nets $design(all_power_nets)
enics_message "Suppressing the following messages that are reported due to the LIB definitions:" 
enics_message "$tech(LIB_SUPPRESS_MESSAGES_INNOVUS)"
set_message -suppress -id $tech(LIB_SUPPRESS_MESSAGES_INNOVUS) 
enics_message "Reading MMMC File" medium
read_mmmc $design(mmmc_view_file) 
#@ Begin verbose source (pre): 
create_constraint_mode \
	-name functional_mode \
	-sdc_files $design(functional_sdc)
if {$runtype=="synthesis"} {...
} else {
set_message -suppress -id ENCEXT-6202 ;
}
create_rc_corner \
	-name bc_rc_corner \
	-temperature $tech(TEMPERATURE_BC) \
    -qrc_tech $tech_files(QRCTECH_FILE_BC)
create_rc_corner \
	-name tc_rc_corner \
	-temperature $tech(TEMPERATURE_TC) \
	-qrc_tech $tech_files(QRCTECH_FILE_TC)
create_rc_corner \
	-name wc_rc_corner \
	-temperature $tech(TEMPERATURE_WC) \
    -qrc_tech $tech_files(QRCTECH_FILE_WC)
create_library_set \
	-name bc_libset \
	-timing $tech_files(ALL_BC_LIBS)  
create_library_set \
	-name tc_libset \
	-timing $tech_files(ALL_TC_LIBS)  
create_library_set \
	-name wc_libset \
	-timing $tech_files(ALL_WC_LIBS)  
create_timing_condition \
   -name         bc_timing_condition \
   -library_sets bc_libset
create_timing_condition \
   -name         tc_timing_condition \
   -library_sets tc_libset
create_timing_condition \
   -name         wc_timing_condition \
   -library_sets wc_libset
create_delay_corner \
	-name bc_dly_corner \
	-timing_condition bc_timing_condition \
	-rc_corner bc_rc_corner
create_delay_corner \
	-name tc_dly_corner \
	-timing_condition tc_timing_condition \
	-rc_corner tc_rc_corner
create_delay_corner \
	-name wc_dly_corner \
	-timing_condition wc_timing_condition \
	-rc_corner wc_rc_corner
create_analysis_view \
	-name bc_analysis_view \
	-constraint_mode functional_mode \
	-delay_corner bc_dly_corner
create_analysis_view \
    -name tc_analysis_view \
	-constraint_mode functional_mode \
	-delay_corner tc_dly_corner
create_analysis_view \
	-name wc_analysis_view \
	-constraint_mode functional_mode \
	-delay_corner wc_dly_corner
set_analysis_view \
	-setup $design(selected_setup_analysis_views) \
	-hold  $design(selected_hold_analysis_views)
#@ End verbose source: /data/project/tsmc65/users/liosky/ws/DVD25/hw7/workspace/../inputs/lp_riscv_top.mmmc
enics_message "Suppressing the following messages that are reported due to the LEF definitions:" 
enics_message "$tech(LEF_SUPPRESS_MESSAGES_INNOVUS)"
set_message -suppress -id $tech(LEF_SUPPRESS_MESSAGES_INNOVUS) 
enics_message "Reading LEF abstracts"
read_physical -lef $tech_files(ALL_LEFS)
enics_message "Reading the Post Synthesis netlist at $design(postsyn_netlist)" medium
read_netlist $design(postsyn_netlist)
enics_message "Running init_design command" medium
init_design
source ../scripts/settings.tcl -quiet
enics_default_cost_groups
enics_message "Connecting Global Nets" medium
connect_global_net $design(digital_gnd) -pin $tech(STANDARD_CELL_GND) -all -verbose
connect_global_net $design(digital_vdd) -pin $tech(STANDARD_CELL_VDD) -all -verbose
connect_global_net $design(digital_vdd) -type tiehi -all -verbose 
connect_global_net $design(digital_gnd) -type tielo -all -verbose 
connect_global_net $design(digital_vdd) -pin $tech(SRAM_VDDCORE_PIN)      -all -verbose 
connect_global_net $design(digital_vdd) -pin $tech(SRAM_VDDPERIPHERY_PIN) -all -verbose 
connect_global_net $design(digital_gnd) -pin $tech(SRAM_GND_PIN)          -all -verbose 
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    # Connect pads to IO and CORE voltages
    #    -netlist_override is needed, since GENUS connects these pins to UNCONNECTED during synthesis
    connect_global_net $design(io_vdd)      -pin $tech(IO_VDDIO)   -hinst i_${design(IO_MODULE)} -netlist_override -verbose
    connect_global_net $design(io_gnd)      -pin $tech(IO_GNDIO)   -hinst i_${design(IO_MODULE)} -netlist_override -verbose
    connect_global_net $design(digital_vdd) -pin $tech(IO_VDDCORE) -hinst i_${design(IO_MODULE)} -netlist_override -verbose
    connect_global_net $design(digital_gnd) -pin $tech(IO_GNDCORE) -hinst i_${design(IO_MODULE)} -netlist_override -verbose
}
enics_create_stage_reports -save_db no -report_timing no -pop_snapshot yes
enics_start_stage "floorplan"
source ../inputs/$design(TOPLEVEL).floorplan.defines -quiet
create_floorplan -site $tech(STANDARD_CELL_SITE) -match_to_site \
    -core_size [list 1200 1000] \
    -flip s
gui_fit
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
enics_message "Defining IO Ring" medium
# Reload the IO file after resizing the floorplan
read_io_file $design(io_file)
# Add IO Fillers
add_io_fillers -cells $tech(IO_FILLERS) -prefix IOFILLER
# Connect Pad Rings
route_special -connect {pad_ring} \
-nets "$design(digital_gnd) $design(digital_vdd) $design(io_gnd) $design(io_vdd)"
} elseif {$design(FULLCHIP_OR_MACRO)=="MACRO"} {
enics_message "Spreading Pins around Macro" medium
    # Spread pins
set pins_to_spread  [get_db ports .name] ;#[get_object_name [get_ports]]
#edit_pin -fix_overlap 1 -spread_direction clockwise -side Bottom -layer 4 -spread_type side 
edit_pin -spread_type start -start {0 0} -spread_direction clockwise -layer {3 4}  \
        -pin $pins_to_spread -fix_overlap 1 -spacing 6

}
gui_redraw
check_legacy_design -all -out_dir $design(reports_dir)/$this_run(stage)
enics_message "Placing Hard Macros" medium
delete_relative_floorplan -all
set imem0_name [get_db [get_db insts -regexp $design(imem0)] .name]
set imem1_name [get_db [get_db insts -regexp $design(imem1)] .name]
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $imem0_name \
         -horizontal_edge_separate [list 1 [expr -485*$tech(row_height)] 1] \
        -vertical_edge_separate [list 0 25 0] -orient MX
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $imem1_name \
        -horizontal_edge_separate [list 1 [expr -485*$tech(row_height)] 1] \
        -vertical_edge_separate {0  700  0} -orient MX
set dmem0_name [get_db [get_db insts -regexp $design(dmem0)] .name]
set dmem1_name [get_db [get_db insts -regexp $design(dmem1)] .name]
set dmem2_name [get_db [get_db insts -regexp $design(dmem2)] .name]
set dmem3_name [get_db [get_db insts -regexp $design(dmem3)] .name]
set core_width [expr [get_db designs .core_boundary.perimeter]/(2*(1+$design(floorplan_ratio)))]
set sram_width [get_db [get_db insts $dmem0_name] .bbox.width]
set sram_spacing [expr ($core_width-4*$sram_width)/5]
create_relative_floorplan -ref_type core_boundary -ref $design(TOPLEVEL) -place $dmem0_name \
    -horizontal_edge_separate [list 1 [expr -15*$tech(row_height)] 1] \
    -vertical_edge_separate [list 0 $sram_spacing 0] -orient R0
create_relative_floorplan -ref_type object -ref $dmem0_name -place $dmem1_name \
    -horizontal_edge_separate {1  0  1} \
    -vertical_edge_separate [list 2 $sram_spacing 0] -orient R0
create_relative_floorplan -ref_type object -ref $dmem1_name -place $dmem2_name \
    -horizontal_edge_separate {1  0  1} \
    -vertical_edge_separate [list 2 $sram_spacing 0] -orient R0
create_relative_floorplan -ref_type object -ref $dmem2_name -place $dmem3_name \
    -horizontal_edge_separate {1  0  1} \
    -vertical_edge_separate [list 2 $sram_spacing 0] -orient R0
enics_message "Adding Rings Around Hard Macros and creating Halos"
deselect_obj -all
select_obj $imem0_name
add_rings -around selected -type block_rings -nets "$design(digital_gnd) $design(digital_vdd)" \
-layer {bottom M1 top M1 right M2 left M2} -width 3 -spacing 0.5
create_place_halo -halo_deltas {10.8 10.8 10.8 10.8} -insts $imem0_name -snap_to_site
deselect_obj -all
select_obj $imem1_name
add_rings -around selected -type block_rings -nets "$design(digital_gnd) $design(digital_vdd)" \
-layer {bottom M1 top M1 right M2 left M2} -width 3 -spacing 0.5
create_place_halo -halo_deltas {10.8 10.8 10.8 10.8} -insts $imem1_name -snap_to_site
deselect_obj -all
select_obj $dmem0_name
add_rings -around selected -type block_rings -nets "$design(digital_gnd) $design(digital_vdd)" \
-layer {bottom M1 top M1 right M2 left M2} -width 3 -spacing 0.5
create_place_halo -halo_deltas {10.8 10.8 10.8 10.8} -insts $dmem0_name -snap_to_site
deselect_obj -all
select_obj $dmem1_name
add_rings -around selected -type block_rings -nets "$design(digital_gnd) $design(digital_vdd)" \
-layer {bottom M1 top M1 right M2 left M2} -width 3 -spacing 0.5
create_place_halo -halo_deltas {10.8 10.8 10.8 10.8} -insts $dmem1_name -snap_to_site
deselect_obj -all
select_obj $dmem2_name
add_rings -around selected -type block_rings -nets "$design(digital_gnd) $design(digital_vdd)" \
-layer {bottom M1 top M1 right M2 left M2} -width 3 -spacing 0.5
create_place_halo -halo_deltas {10.8 10.8 10.8 10.8} -insts $dmem2_name -snap_to_site 
deselect_obj -all
select_obj $dmem3_name
add_rings -around selected -type block_rings -nets "$design(digital_gnd) $design(digital_vdd)" \
-layer {bottom M1 top M1 right M2 left M2} -width 3 -spacing 0.5
create_place_halo -halo_deltas {10.8 10.8 10.8 10.8} -insts $dmem3_name -snap_to_site
enics_message "Connecting Block Pins of hard macros to Power/Ground"
route_special -connect {block_pin} -nets "$design(digital_gnd) $design(digital_vdd)" \
    -block_pin_layer_range {1 4} \
    -block_pin on_boundary \
    -detailed_log
enics_message "Creating Core Rings" medium
add_rings -type core_rings -nets $design(core_ring_nets) -center 1 -follow core \
-layer $design(core_ring_layers) -width $design(core_ring_width) -spacing $design(core_ring_spacing) 
enics_message "Routing Follow Pins" medium
route_special -connect { core_pin } -nets  "$design(digital_gnd) $design(digital_vdd)" -detailed_log
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    # Connect pads to the rings
    enics_message "Connecting PG Pads to Core Ring" medium
    route_special -connect {pad_pin} -nets $design(core_ring_nets) -pad_pin_port_connect all_geom -detailed_log
}
if {$tech(LIBRARY_HAS_ENDCAPS)=="YES"} {
    # get_db -category add_endcaps *
    enics_message "Adding End Caps" medium
    add_endcaps  
}
enics_message "Adding Well Taps" medium
add_well_taps -cell $tech(WELLTAP)  -checker_board -prefix $design(well_tap_prefix) \
    -cell_interval [expr 2 * $tech(WELLTAP_RULE)] 
check_well_taps -max_distance $tech(WELLTAP_RULE)
enics_message "Creating Power Grid" high
add_stripes -layer [lindex [get_db layers .name] 1] -direction vertical -nets $design(M2_stripe_nets) \
    -width $design(M2_stripes_width) -spacing $design(M2_stripes_spacing) \
    -start_from left -start_offset $design(M2_stripes_from_left) \
    -set_to_set_distance $design(M2_stripes_interval) -create_pins true \
    -max_same_layer_jog_length 10.0
enics_create_stage_reports -pop_snapshot yes 
write_def -floorplan -no_std_cells "$design(floorplan_def)"
enics_start_stage "placement"
enics_message "Creating M2 blockage around stripes"
deselect_obj -all
deselect_routes
select_routes -shapes stripe -layer M2 -nets $design(M2_stripe_nets)
foreach stripe [get_db selected] {
    create_route_blockage -name M2_pwr_stripe_route_blk \
-layers "M1 M2" \
-spacing 0.2 \
-area [get_db $stripe .rect]
}
deselect_routes
enics_message "Starting place_opt_design" medium
set_db place_global_cong_effort auto
place_opt_design -report_dir "$design(reports_dir)/placement/place_opt_design" 
enics_message "Finished place_opt_design"
enics_message "Adding Tie Cells" medium
add_tieoffs
enics_message "Fixing DRVs before CTS" medium
opt_design -pre_cts -drv
enics_create_stage_reports -pop_snapshot yes
enics_start_stage "cts"
enics_message "Reading in clock spec from $design(clock_tree_spec)"
reset_ccopt_config
#@ source $design(clock_tree_spec)
#@ Begin verbose source (pre): source $design(clock_tree_spec)
foreach clk_name $design(clock_list) \
        clk_port $design(clock_port_list) \
        clk_period $design(clock_period_list) {
            create_clock_tree -name $clk_name -source $clk_port -no_skew_group
            create_skew_group -name $clk_name -sources $clk_port -auto_sinks
            set_db clock_tree:$clk_name .cts_source_driver $tech(CCOPT_DRIVING_PIN)
            set_db port:$clk_port .cts_clock_period $clk_period
        }
set_db cts_target_max_transition_time $design(CLOCK_MAX_TRANSITION)
set_db cts_max_fanout  $design(CLOCK_MAX_FANOUT)
set_db cts_target_max_capacitance $design(CLOCK_MAX_CAPACITANCE)
set_db cts_buffer_cells $tech(CLOCK_BUFFERS)
set_db cts_clock_gating_cells $tech(CLOCK_GATES)
set_db cts_inverter_cells  $tech(CLOCK_INVERTERS)
set_db cts_logic_cells $tech(CLOCK_LOGIC)
set_db cts_delay_cells $tech(CLOCK_DELAYS)
check_clock_tree_convergence
#@ End verbose source: /data/project/tsmc65/users/liosky/ws/DVD25/hw7/workspace/../inputs/lp_riscv_top.ccopt
enics_message "Starting ccopt_design" medium
ccopt_design -report_dir "$design(reports_dir)/cts/ccopt_design"  
enics_message "Finished running ccopt_design"
enics_create_stage_reports -pop_snapshot yes
enics_start_stage "post_cts_hold"
opt_design -post_cts -hold
enics_message "Finished post CTS hold optimization"
enics_create_stage_reports -pop_snapshot yes
enics_start_stage "route"
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
set_db route_design_detail_use_multi_cut_via_effort medium
enics_message "Starting Route Design" medium
route_opt_design
enics_message "Finished running Route Design"
enics_create_stage_reports -check_drc yes -check_connectivity yes -pop_snapshot yes
enics_start_stage "post_route_opt"
opt_design -post_route -setup -hold
enics_message "Running Post Route DFM Optimizations" medium
set_db route_design_with_timing_driven false
set_db route_design_with_si_driven false
set_db route_design_detail_post_route_spread_wire true
set_db route_design_detail_use_multi_cut_via_effort high
route_design -wire_opt
route_design -via_opt
set_db route_design_detail_post_route_spread_wire false
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
enics_message "Finished Running Post Route DFM Optimizations" 
enics_create_stage_reports -check_drc yes -check_connectivity yes -pop_snapshot yes
enics_start_stage "signoff"
delete_route_blockages -name M2_pwr_stripe_route_blk;
enics_message "Adding Fillers" medium
add_fillers -check_drc
set_db route_design_with_si_driven false
enics_message "Fixing DRCs after adding fillers" medium
route_eco -fix_drc
delete_assigns
delete_empty_hinst
enics_message "Exporting Design" medium
write_netlist $design(postroute_netlist)
write_sdf $design(postroute_sdf)
set_db write_stream_text_size 0.02;
write_stream $design(export_dir)/signoff/$design(TOPLEVEL).gds
enics_create_stage_reports -check_drc yes -check_connectivity yes -pop_snapshot yes
exit
