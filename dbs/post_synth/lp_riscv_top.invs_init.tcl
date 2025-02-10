################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 01/21/2025 17:10:33
#
################################################################################
if { ![is_common_ui_mode] } { error "ERROR: This script requires common_ui to be active."}

read_mmmc /data/project/tsmc65/users/liosky/ws/DVD25/hw6/workspace/../dbs/post_synth/lp_riscv_top.mmmc.tcl

read_netlist /data/project/tsmc65/users/liosky/ws/DVD25/hw6/workspace/../dbs/post_synth/lp_riscv_top.v

init_design
