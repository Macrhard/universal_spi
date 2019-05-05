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
wire [`SPI_CHAR_LEN_BITS:0] w_rx_bit_pos;
wire w_rx_clk_en;
wire w_tx_clk_en;
assign o_parallel_out = r_data;
assign w_tx_bit_pos = i_lsb ? {!(|i_len),i_len} - r_cnt : r_cnt - {{`SPI_CHAR_LEN_BITS{1'b0}},1'b1};
assign w_rx_bit_pos = i_lsb ? {!(|i_len),i_len} - (i_rx_negedge ? r_cnt + {{`SPI_CHAR_LEN_BITS{1'b0}},1'b1} : r_cnt) : (i_rx_negedge ? cnt : cnt - {{`SPI_CHAR_LEN_BITS{1'b0}},1'b1});
assign o_last = !(|r_cnt);
assign w_rx_clk_en = (i_rx_negedge ? i_neg_edge : i_pos_edge) && (!o_last || i_serial_clk);
assign w_tx_clk_en = (i_tx_negedge ? i_neg_edge : i_pos_edge) && !o_last;

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_cnt <= #Tp {`SPI_CHAR_LEN_BITS + 1{1'b0}};
    else begin
        if(r_tip)
            r_cnt <= #Tp i_pos_edge ? (r_cnt - {{`SPI_CHAR_LEN_BITS + 1{1'b0}},1'b1}) : r_cnt;
        else  
            r_cnt <= #Tp !(|i_len) ? {1'b1,{`SPI_CHAR_LEN_BITS{1'b0}} : {1'b0,i_len};
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_tip <= Tp 1'b0;
    else if(i_go && ~r_tip)
        r_tip <= #Tp 1'b1;
    else if(r_tip && o_last && i_pos_edge)
        r_tip <= #Tp 1'b0;
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_serial_out <= #Tp 1'b0;
    else
        o_serial_out <= #Tp(w_tx_clk_en || !r_tip) ? r_data[w_tx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]] : r_serial_out;
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_data <= #Tp {`SPI_MAX_CHAR{1'b0}};
`ifdef SPI_MAX_CHAR_128
    else if(i_latch[0] && !r_tip) begin
        if(i_byte_sel[3])
            r_data <= #Tp i_parallel_in[31:24];
        if(i_byte_sel[2])
            r_data <= #Tp i_parallel_in[23:16];
        if(i_byte_sel[1])
            r_data <= #Tp i_parallel_in[15:8];
        if(i_byte_sel[0])
            r_data <= #Tp i_parallel_in[7:0];
    end
    else if(i_latch[1] && !r_tip) begin
        if(i_byte_sel[3])
            r_data[63:56] <= #Tp i_parallel_in[31:24];

    end
    `ifdef SPI_MAX_CHAR_24
        if(i_byte_sel[0])
            r_data[7:0] <= #Tp i_parallel_in[7:0];
        if(i_byte_sel[1])
            r_data[15:8] <= #Tp i_parallel_in[15:8];
        if(i_byte_sel[2])
            r_data[23:16] <= #Tp i_parallel_in[23:16];
        if(i_byte_sel[3])
            r_data[`SPI_MAX_CHAR-1:24] <= #Tp i_parallel_in[`SPI_MAX_CHAR-1:24];
    `endif
end
`endif
`endif
    else
        r_data[w_rx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]] <= #Tp w_rx_clk_en ? i_serial_in : r_data[w_rx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]];
end
endmodule // spi_shift