# Cadence Genus(TM) Synthesis Solution, Version 21.15-s080_1, built Sep 23 2022 12:57:55

# Date: Tue Jan 21 15:18:39 2025
# Host: ip-10-70-140-38.il-central-1.compute.internal (x86_64 w/Linux 4.14.355-275.570.amzn2.x86_64) (1core*2cpus*1physical cpu*Intel(R) Xeon(R) Platinum 8375C CPU @ 2.90GHz 55296KB)
# OS:   CentOS Linux release 7.9.2009 (Core)

source scripts/genus.tcl
set debug_file "debug.txt"
set design(TOPLEVEL) "lp_riscv_top"
set runtype "synthesis"
set mmmc_or_simple "simple"; # "simple" - using "read_libs"
set phys_synth_type "none" ;  # "none"   - don't read any physical data
source ../scripts/procedures.tcl -quiet
enics_start_stage "start"
source ../inputs/$design(TOPLEVEL).defines -quiet
source ../scripts/settings.tcl -quiet
source ../libraries/libraries.$TECHNOLOGY.tcl -quiet
source ../libraries/libraries.$SC_TECHNOLOGY.tcl -quiet
source ../libraries/libraries.$SRAM_TECHNOLOGY.tcl -quiet
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    source ../libraries/libraries.$IO_TECHNOLOGY.tcl -quiet
}
set var_list {runtype mmmc_or_simple phys_synth_type}
set dic_list {paths tech tech_files design}
enics_print_debug_data w $debug_file "after everything was loaded" $var_list $dic_list
enics_start_stage "init_design"
enics_message "Suppressing the following messages that are reported due to the library definitions:"
enics_message "$tech(LIB_SUPPRESS_MESSAGES_GENUS)"
suppress_messages $tech(LIB_SUPPRESS_MESSAGES_GENUS)
if {$mmmc_or_simple=="mmmc"} {
    enics_message "Loading MMMC File"
    read_mmmc $design(mmmc_view_file)
} else {
    enics_message "Reading library definitions (without MMMC Flow)"
    set_db init_lib_search_path $paths(LIB_paths) 
    suppress_messages $tech(LIB_SUPPRESS_MESSAGES_GENUS)
    suppress_messages "LBR-38"; # A message that shouldn't appear in MMMC Flow
    read_libs $tech_files(ALL_WC_LIBS)
}
if {$phys_synth_type == "none"} {
   enics_message "Physical Synthesis is disabled"
   #read_qrc $tech_files(QRCTECH_FILE_WC)
} else {
    # Suppress messages
    enics_message "Suppressing the following messages that are reported due to the LEF definitions:" 
    enics_message "$tech(LEF_SUPPRESS_MESSAGES_GENUS)"
    suppress_messages $tech(LEF_SUPPRESS_MESSAGES_GENUS)
    enics_message "Loading the library abstracts"
    read_physical -lef $tech_files(ALL_LEFS)
    if {$phys_synth_type == "floorplan"} { 
        # You need to read a .def file for the floorplan to enable physical synthesis 
        enics_message "Loading the floorplan def"
        read_def $design(floorplan_def)
    }
}
enics_message "Suppressing the following messages that are design specific"
enics_message "$design(DESIGN_SUPPRESS_MESSAGES_GENUS)"
suppress_messages $design(DESIGN_SUPPRESS_MESSAGES_GENUS)
enics_start_stage "read_rtl"
set_db init_hdl_search_path $design(hdl_search_paths)
read_hdl -language sv -f $design(read_hdl_list)
if {$mmmc_or_simple=="mmmc"} {
    enics_message "Running init_design in an MMMC flow"
    init_design
}
enics_start_stage "elaborate"
elaborate $design(TOPLEVEL) ;#-update
enics_start_stage "post_elaboration"
enics_message "Checking design post elaboration"
check_design -unresolved
check_design -all > $design(synthesis_reports)/post_elaboration/check_design_post_elab.rpt
if {[check_design -status]} {
    Puts "ENICSINFO: ############# There is an issue with check_design. You better look at it! ###########"
}
write_design -base_name $design(export_dir)/post_elaboartion/$design(TOPLEVEL)
enics_message "Reading SDC"
read_sdc $design(functional_sdc) -stop_on_errors
enics_message "Checking timing intent (lint) after loading SDC"
check_timing_intent
check_timing_intent -verbose > $design(synthesis_reports)/post_elaboration/check_timing_post_elab.rpt
enics_default_cost_groups
enics_report_timing $design(synthesis_reports)
set_db [get_db design:$design(TOPLEVEL)] .lp_clock_gating_min_flops 8
set_db [get_db design:$design(TOPLEVEL)] .lp_clock_gating_style latch
enics_start_stage "synthesis"
set_db syn_generic_effort low
set_db syn_map_effort low
set_db syn_opt_effort low
enics_message "Setting Don't Use on scan flip flops"
foreach cell [get_db lib_cells -if {.scan_enable_pins!=""}] {set_db $cell .avoid true}
if {$phys_synth_type == "floorplan"} {
    # Synthesize to generics and place generics in floorplan
    enics_start_stage "syn_generic"
    syn_generic -physical
    # Map to technology
    enics_start_stage "technology_mapping"
    syn_map -physical
    enics_report_timing $design(synthesis_reports) 
    # Post synthesis optimization
    enics_start_stage "post_syn_opt"
    syn_opt -physical
} else {
    # Synthesize to generics (non physical-aware)
    enics_start_stage "syn_generic"
    syn_generic 
    # Map to technology (non physical-aware)
    enics_start_stage "technology_mapping"
    syn_map 
    enics_report_timing $design(synthesis_reports)
    enics_start_stage "post_syn_opt"
    if {$phys_synth_type == "lef"} {
        syn_opt -physical
    } else {
        syn_opt 
    }
}
enics_report_timing $design(synthesis_reports)
set post_synth_reports [list \
    report_area \
    report_gates \
    report_hierarchy \
    report_clock_gating \
    report_design_rules \
    report_dp \
    report_qor \
]
foreach rpt $post_synth_reports {
    enics_message "$rpt" medium
    $rpt
    $rpt > "$design(synthesis_reports)/$this_run(stage)/${rpt}.rpt"
}
enics_start_stage "export_design"
enics_message "Exporting the design Database to $design(postsyn_db_base_name)"
write_design -base_name $design(postsyn_db_base_name) -innovus -db
enics_message "Writing the post synthesis netlist to $design(postsyn_netlist)"
write_hdl > $design(postsyn_netlist)
enics_message "Writing the post synthesis SDF"
mkdir -pv $design(export_dir)/post_synth
write_sdf > $design(postsyn_sdf)
exit
