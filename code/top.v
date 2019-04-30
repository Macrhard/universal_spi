module top(
    input           i_clk,
    input [79:0]    i_data,
    input           i_rst_n,
    input           i_rw_en,
    input           i_miso,
    output          o_mosi,
    output [7:0]    o_ss,
    output          o_sck
);

