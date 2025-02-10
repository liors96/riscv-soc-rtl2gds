database -open -event waves -into waves.shm -default
probe -create tb_lp_riscv  -depth all -tasks -functions -uvm -packed 16k -unpacked 64k -all -dynamic -memories -database waves
run