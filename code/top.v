module top(
input            i_clk,
input            i_rst_n,
input   [4:0]    i_addr,
input   [31:0]   i_data,
output  [31:0]   o_data,
input   [3:0]    i_byte_sel,
input            i_write_en, //输入数据的写使能，向控制寄存器写入控制字
input            i_stb,       //表示一个有效数据传送周期
input            i_cyc,       //
output           o_ack,
output           o_err,
output           o_ini
);

reg [`SPI_CTRL_BIT_NUM-1：0] ctrl;

always @(posedge i_clk or negedge wb_rst_i) begin
    if(!i_rst_n)
        ctrl <= #Tp {`SPI_CTRL_BIT_NUM{1'b0}};
    else if(psi_ctrl_sel && we_i && !tip) begin
        if(i_byte_sel[0])
            ctrl[7:0] <= #Tp wb_data_i[7:0] | {7'b0, ctrl[0]};
        if(i_byte_sel[1]
            ctrl[`SPI_CTRL_BIT_NUM-1:8] <= #Tp wb_data_i[`SPI_CTRL_BIT_NUM-1:8];
    end
    else if(tip && last_bit && pos_edge)
        ctrl[`SPI_CTRL_GO] <= #Tp 1'b0;
end

assign rx_negedge = ctrl[`SPI_CTRL_RX_NEGEDGE];
assign tx_negedge = ctrl[`SPI_CTRL_TX_NEGEDGE];
assign go = ctrl[`SPI_CTRL_GO];
assign char_len = ctrl[`SPI_CTRL_CHAR_LEN];
assign lsb = ctrl[`SPI_CTRL_LSB];
assign ie = ctrl[`SPI_CTRL_LSB];
assign ass = ctrl[`SPI_CTRL_ASS];

always @(posedge i_clk or negedge wb_rst_i) begin
    if(wb_rst_i)
        divider = #Tp {`SPI_DIVIDER_LEN{1'b0}};
    else if(spi_divider_sel && i_write_en && !tip) begin
        `ifdef SPI_DIVIDER_LEN_8
            if(i_byte_sel[0])
                divider <= #Tp i_data[`SPI_DIVIDER_LEN-1:0];
        `endif
        `ifdef SPI_DIVIDER_LEN_16
            if(i_byte_sel[0])
                divider[7:0] <= #Tp i_data[7:0];
            if(i_byte_sel[1])
                divider[`SPI_DIVIDER_LEN-1:8] <= #Tp i_data[`SPI_DIVIDER_LEN-1:16];
        `endif
        `ifdef SPI_DIVIDER_LEN_24
            if(i_byte_sel[0])
                divider[7:0] <= #Tp i_data[7:0];
            if(i_byte_sel[1])
                divider[15:8] <= #Tp i_data[15:8];
            if(i_byte_sel[2])
                divider[`SPI_DIVIDER_LEN-1:16] <= #Tp i_data[`SPI_DIVIDER_LEN-1:16];
        `endif
        `ifdef SPI_DIVIDER_LEN_32
            if(i_byte_sel[0])
                divider[7:0] <= #Tp i_data[7:0];
            if(i_byte_sel[1])
                divider[15:8] <= #Tp i_data[15:8];
            if(i_byte_sel[2])
                divider[23:16] <= #Tp i_data[23:16];
            if(i_byte_sel[3])
                divider[`SPI_DIVIDER_LEN-1:24] <= #Tp i_data[`SPI_DIVIDER_LEN-1:24];
        `endif
    end
end

spi_clk_gen spi_clk_gen(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_enable   (w_tip),
    .i_tx_start (go),
    .i_last_clk (w_last),
    .i_divider  (divider),
    .o_clk_out  (w_sclk),
    .o_pos_edge (w_pos_edge),
    .o_neg_edge (w_neg_edge)
);

assign o_pad_sclk = w_sclk;
spi_shift spi_shift(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_latch    (spi_tx_sel[3:0]&{4{i_write_en}}),
    .i_byte_sel (i_byte_sel),
    .i_len      (char_len[`SPI_CHAR_LEN_BITS-1:0]),
    .i_lsb      (lsb),
    .i_go       (go),
    .i_pos_edge (w_pos_edge),
    .i_neg_edge (w_neg_edge),
    .i_parallel_in  (i_data),
    .i_serial_in    (i_pad_miso),
    .i_serial_clk   (w_sclk),
    .o_tip          (w_tip),
    .o_last         (w_last),
    .o_parallel_out (rx_data), //rx
    .o_serial_out   (o_pad_mosi),
);



spi_clk_gen     u_spi_clk_gen(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_enable   (tip),
    .i_tx_start (go),
    .i_last_clk (last_bit),
    .i_divider  (divider),
    .o_clk_out  (sclk_pad_o),
    .o_pos_edge (pos_edge),
    .o_neg_edge (neg_edge)
);


spi_shift       u_spi_shift(
    .i_clk      (i_clk),
    .i_rst_n    (!wb_rst_i),
    .i_latch    (i_latch),
    .
);

endmodule

