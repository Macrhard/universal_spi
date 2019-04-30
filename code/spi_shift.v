module spi_shift(
    input       i_clk,
    input       i_rst_n,
    input [3:0] i_latch,
    input [3:0] i_byte_sel,
    input [`SPI_CHAR_LEN_BITS-1:0] i_len,
    input       i_lsb,
    input       i_go,
    input       i_pos_edge,
    input       i_neg_edge,
    input       i_rx_negedge,
    input       i_tx_negedge,
    input [31:0] i_parallel_in,
    input       i_serial_in,
    input       i_serial_clk,
    output      o_tip,
    output      o_last,
    output [`SPI_CHAR_LEN_BITS-1:0] o_parallel_out,
    output      o_serial_out
);

reg r_serial_out;
reg r_tip;
reg [`SPI_CHAR_LEN_BITS] r_cnt;
reg [`SPI_MAX_CHAR-1:0]  r_data;
wire [`SPI_CHAR_LEN_BITS:0] w_tx_bit_pos;
wire [`SPI_CHAR_LEN_BITS:0] w_rx_bot_pos;
wire w_rx_clk_en;
wire w_tx_clk_en;
assign o_parallel_out = r_data;
assign w_tx_bit_pos = i_lsb ? {!(|i_len),i_len} - r_cnt : r_cnt - {{`SPI_CHAR_LEN_BITS},1'b1}:r_cnt):(i_rx_negedge ? r_cnt : r_cnt - {{`SPI_CHAR_LEN_BITS{1'b0}},1'b1});
assign o_last = !(|r_cnt);
assign w_rx_clk_en = (i_rx_negedge ? i_neg_edge : i_pos_edge) && (!o_last || i_serial_clk);

endmodule // spi_shift