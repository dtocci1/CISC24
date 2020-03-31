vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/blk_mem_gen_v8_4_4
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap blk_mem_gen_v8_4_4 activehdl/blk_mem_gen_v8_4_4
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 \
"C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_4  -v2k5 \
"../../../../CISC24.srcs/sources_1/bd/BlockRAM/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/BlockRAM/ip/BlockRAM_blk_mem_gen_0_0/sim/BlockRAM_blk_mem_gen_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/BlockRAM/sim/BlockRAM.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

