################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 01/21/2025 17:02:04
#
################################################################################
if { ![is_common_ui_mode] } { error "ERROR: This script requires common_ui to be active."}

read_netlist /data/project/tsmc65/users/liosky/ws/DVD25/hw6/workspace/../export/post_elaboartion/lp_riscv_top.v

init_design -skip_sdc_read
