vlib work
vmap work work
vlog -f filelist
vsim -t ns -novopt work.clk_gen_top_tb
add wave -position insertpoint  \
sim:/clk_gen_top_tb/spi_clk_gen/i_clk \
sim:/clk_gen_top_tb/spi_clk_gen/i_divider \
sim:/clk_gen_top_tb/spi_clk_gen/i_last_clk \
sim:/clk_gen_top_tb/spi_clk_gen/o_clk_out \
sim:/clk_gen_top_tb/spi_clk_gen/i_enable \
sim:/clk_gen_top_tb/spi_clk_gen/r_clk1 \
sim:/clk_gen_top_tb/spi_clk_gen/r_clk2 \
sim:/clk_gen_top_tb/spi_clk_gen/r_clk3 \
sim:/clk_gen_top_tb/spi_clk_gen/r_cnt1 \
sim:/clk_gen_top_tb/spi_clk_gen/r_cnt2 \
sim:/clk_gen_top_tb/spi_clk_gen/w_clk_out \
sim:/clk_gen_top_tb/spi_clk_gen/r_cnt3 
run 50000ns