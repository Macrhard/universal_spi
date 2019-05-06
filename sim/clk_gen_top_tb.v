`include "../code/define.v"
`timescale 1ns/1ps
module clk_gen_top_tb();
reg i_clk;
reg i_rst_n;
reg i_enable;
reg i_tx_start;
reg i_last_clk;
reg [`SPI_DIVIDER_LEN-1:0] i_divider;
wire o_clk_out;
wire o_pos_edge;
wire o_neg_edge;

spi_clk_gen spi_clk_gen(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_enable   (i_enable),
    .i_tx_start (i_tx_start),
    .i_last_clk (i_last_clk),
    .i_divider  (i_divider),
    .o_clk_out  (o_clk_out),
    .o_pos_edge (o_pos_edge),
    .o_neg_edge (o_neg_edge)
);

initial begin
                i_clk = 1'b0;
                i_last_clk = 1'b0;
                i_divider = 8'd6;
    #10         i_rst_n = 1'b0;
    #50         i_rst_n = 1'b1;
    #20         i_enable = 1'b1;
                i_tx_start = 1'b1;
    #1000       i_last_clk = 1'b1;
end

always #10 i_clk = ~i_clk;
//always #40 i_clk = ~i_clk;
endmodule