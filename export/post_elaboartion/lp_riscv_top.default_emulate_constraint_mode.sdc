# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.15-s080_1 on Tue Jan 21 17:01:58 UTC 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design lp_riscv_top

set_clock_gating_check -setup 0.0 
set_wire_load_mode "top"
