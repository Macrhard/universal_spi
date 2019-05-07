onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/i_clk
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/i_divider
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/i_last_clk
add wave -noupdate -color {Orange Red} /clk_gen_top_tb/spi_clk_gen/o_clk_out
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/i_enable
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/r_clk1
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/r_clk2
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/r_clk3
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/r_cnt1
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/r_cnt2
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/w_clk_out
add wave -noupdate /clk_gen_top_tb/spi_clk_gen/r_cnt3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1642 ns} 0} {{Cursor 3} {2390 ns} 0} {{Cursor 4} {13488 ns} 0}
quietly wave cursor active 3
configure wave -namecolwidth 369
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {13342 ns} {13774 ns}
