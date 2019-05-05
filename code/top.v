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

wb_clk_i;
wb-wb_rst_i;
wb_adr_i[4:0];
wb_dat_i[31:0];
wb_dat_o[31:0];
wb_sel_i[3:0];
wb_we_i;
wb_stb_i;
wb_cyc_i;
wb_ack_o;
wb_err_o;
wb_ini_o;

always @(posedge wb_clk_i or negedge wb_rst_i) begin
    if(wb_rst_i)
        ctrl <= #Tp {`SPI_CTRL_BIT_NUM{1'b0}};
    else if(psi_ctrl_sel && we_i && !tip) begin
        if(wb_sel_i[0])
            ctrl[7:0] <= #Tp wb_data_i[7:0] | {7'b0, ctrl[0]};
        if(wb_sel_i[1]
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

always @(posedge wb_clk_i or negedge wb_rst_i) begin
    if(wb_rst_i)
        divider = #Tp {`SPI_DIVIDER_LEN{1'b0}};
    else if(spi_divider_sel && wb_we_i && !tip) begin
        `ifdef SPI_DIVIDER_LEN_8
            if(wb_sel_i[0])
                divider <= #Tp wb_dat_i[`SPI_DIVIDER_LEN-1:0];
        `endif
        `ifdef SPI_DIVIDER_LEN_16
            if(wb_sel_i[0])
                divider[7:0] <= #Tp wb_dat_i[7:0];
            if(wb_sel_i[1])
                divider[`SPI_DIVIDER_LEN-1:8] <= #Tp wb_dat_i[`SPI_DIVIDER_LEN-1:16];
        `endif
        `ifdef SPI_DIVIDER_LEN_24
            if(wb_sel_i[0])
                divider[7:0] <= #Tp wb_dat_i[7:0];
            if(wb_sel_i[1])
                divider[15:8] <= #Tp wb_dat_i[15:8];
            if(wb_sel_i[2])
                divider[`SPI_DIVIDER_LEN-1:16] <= #Tp wb_dat_i[`SPI_DIVIDER_LEN-1:16];
        `endif
        `ifdef SPI_DIVIDER_LEN_32
            if(wb_sel_i[0])
                divider[7:0] <= #Tp wb_dat_i[7:0];
            if(wb_sel_i[1])
                divider[15:8] <= #Tp wb_dat_i[15:8];
            if(wb_sel_i[2])
                divider[23:16] <= #Tp wb_dat_i[23:16];
            if(wb_sel_i[3])
                divider[`SPI_DIVIDER_LEN-1:24] <= #Tp wb_dat_i[`SPI_DIVIDER_LEN-1:24];
        `endif
    end
end

spi_clk_gen     u_spi_clk_gen(
    .i_clk      (wb_clk_i),
    .i_rst_n    (!wb_rst_i),
    .i_enable   (tip),
    .i_tx_start (go),
    .i_last_clk (last_bit),
    .i_divider  (divider),
    .o_clk_out  (sclk_pad_o),
    .o_pos_edge (pos_edge),
    .o_neg_edge (neg_edge)
);


spi_shift       u_spi_shift(
    .i_clk      (wb_clk_i),
    .i_rst_n    (!wb_rst_i),
    .i_latch    (i_latch),
    .
);

endmodule

