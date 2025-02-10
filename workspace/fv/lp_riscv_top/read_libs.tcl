add_search_path /data/tsmc/65LP/dig_libs/ARM_FEONLY/arm/tsmc/cln65lp/sc9_base_rvt/r0p0/lib/ /data/tsmc/65LP/dig_libs/ARM_FEONLY/arm/tsmc/cln65lp/sc9_base_lvt/r0p0/lib/ /data/tsmc/65LP/dig_libs/ARM_FEONLY/arm/tsmc/cln65lp/sc9_base_hvt/r0p0/lib/ -library -both
read_library -liberty -both \
    /data/tsmc/65LP/dig_libs/ARM_FEONLY/arm/tsmc/cln65lp/sc9_base_rvt/r0p0/lib/sc9_cln65lp_base_rvt_ss_typical_max_0p90v_125c.lib \
    /data/tsmc/65LP/dig_libs/ARM_FEONLY/arm/tsmc/cln65lp/sc9_base_lvt/r0p0/lib/sc9_cln65lp_base_lvt_ss_typical_max_0p90v_125c.lib \
    /data/tsmc/65LP/dig_libs/ARM_FEONLY/arm/tsmc/cln65lp/sc9_base_hvt/r0p0/lib/sc9_cln65lp_base_hvt_ss_typical_max_0p90v_125c.lib \
    /project/tsmc65/users/liosky/ws/DVD25/hw6/workspace/../mem_gen/SP_8192X32/M16/sp_hse_8192_m16_ss_1p08v_1p08v_125c.lib \
    /project/tsmc65/users/liosky/ws/DVD25/hw6/workspace/../mem_gen/SP_16384X32/M16/sp_hde_16384_m16_ss_1p08v_1p08v_125c.lib \
    /data/tsmc/65LP/dig_libs/ARM_FEONLY/TSMCHOME_fe/digital/Front_End/timing_power_noise/NLDM/tpdn65lpnv2od3_200a/tpdn65lpnv2od3wc.lib

