# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.15-s080_1 on Tue Jan 21 17:10:25 UTC 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design lp_riscv_top

set_case_analysis 0 [get_ports PAD_TEST_EN]
set_case_analysis 1 [get_ports PAD_CLOCK_EN]
create_clock -name "CLK" -period 5.0 -waveform {0.0 2.5} [get_ports PAD_CLK]
set_load -pin_load 2.7828000000000004 [get_ports PAD_DONE_FLAG]
set_max_delay 4.5 -from [list \
  [get_ports PAD_TEST_EN]  \
  [get_ports PAD_RST_N]  \
  [get_ports PAD_IRAM_PROG_WR]  \
  [get_ports PAD_IRAM_PROG_DATA_BYTE]  \
  [get_ports PAD_IRAM_PROG_BYTE_IDX_1]  \
  [get_ports PAD_IRAM_PROG_BYTE_IDX_0]  \
  [get_ports PAD_IRAM_PROG_BYTE_7]  \
  [get_ports PAD_IRAM_PROG_BYTE_6]  \
  [get_ports PAD_IRAM_PROG_BYTE_5]  \
  [get_ports PAD_IRAM_PROG_BYTE_4]  \
  [get_ports PAD_IRAM_PROG_BYTE_3]  \
  [get_ports PAD_IRAM_PROG_BYTE_2]  \
  [get_ports PAD_IRAM_PROG_BYTE_1]  \
  [get_ports PAD_IRAM_PROG_BYTE_0]  \
  [get_ports PAD_IRAM_PROG_ADDR_BYTE]  \
  [get_ports PAD_FETCH_EN]  \
  [get_ports PAD_EXT_PERF_COUNTERS_9]  \
  [get_ports PAD_EXT_PERF_COUNTERS_8]  \
  [get_ports PAD_EXT_PERF_COUNTERS_7]  \
  [get_ports PAD_EXT_PERF_COUNTERS_6]  \
  [get_ports PAD_EXT_PERF_COUNTERS_5]  \
  [get_ports PAD_EXT_PERF_COUNTERS_4]  \
  [get_ports PAD_EXT_PERF_COUNTERS_3]  \
  [get_ports PAD_EXT_PERF_COUNTERS_2]  \
  [get_ports PAD_EXT_PERF_COUNTERS_15]  \
  [get_ports PAD_EXT_PERF_COUNTERS_14]  \
  [get_ports PAD_EXT_PERF_COUNTERS_13]  \
  [get_ports PAD_EXT_PERF_COUNTERS_12]  \
  [get_ports PAD_EXT_PERF_COUNTERS_11]  \
  [get_ports PAD_EXT_PERF_COUNTERS_10]  \
  [get_ports PAD_EXT_PERF_COUNTERS_1]  \
  [get_ports PAD_EXT_PERF_COUNTERS_0]  \
  [get_ports PAD_CLOCK_EN]  \
  [get_ports PAD_CLK] ] -to [get_ports PAD_DONE_FLAG]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_TEST_EN]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_RST_N]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_WR]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_DATA_BYTE]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_IDX_1]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_IDX_0]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_7]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_6]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_5]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_4]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_3]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_2]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_1]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_BYTE_0]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_IRAM_PROG_ADDR_BYTE]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_FETCH_EN]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_9]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_8]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_7]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_6]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_5]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_4]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_3]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_2]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_15]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_14]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_13]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_12]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_11]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_10]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_1]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_EXT_PERF_COUNTERS_0]
set_input_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_CLOCK_EN]
set_output_delay -clock [get_clocks CLK] -add_delay 1.25 [get_ports PAD_DONE_FLAG]
set_max_fanout 20.000 [current_design]
set_max_transition 0.35 [current_design]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_TEST_EN]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_RST_N]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_WR]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_DATA_BYTE]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_IDX_1]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_IDX_0]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_7]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_6]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_5]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_4]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_3]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_2]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_1]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_BYTE_0]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_IRAM_PROG_ADDR_BYTE]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_FETCH_EN]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_9]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_8]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_7]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_6]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_5]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_4]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_3]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_2]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_15]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_14]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_13]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_12]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_11]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_10]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_1]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_EXT_PERF_COUNTERS_0]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_CLOCK_EN]
set_driving_cell -lib_cell PDDW1216SCDG -library tpdn65lpnv2od3wc -pin "PAD" [get_ports PAD_CLK]
set_ideal_network [get_ports PAD_RST_N]
set_ideal_network [get_ports PAD_CLK]
set_wire_load_mode "top"
set_clock_uncertainty -setup 0.125 [get_clocks CLK]
set_clock_uncertainty -hold 0.125 [get_clocks CLK]
