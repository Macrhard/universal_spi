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
output           o_ini,

//spi interface
output           o_pad_mosi,
output           o_pad_ss,
output           o_pad_sclk,
input            i_pad_miso           
);

reg [`SPI_CTRL_BIT_NUM-1：0] r_ctrl;
reg [`SPI_DIVIDER_LEN-1:0] r_divider;
//clk_gen module out
wire w_pos_edge;
wire w_neg_edge;
wire w_sclk；
//shift module out
wire w_last;
wire w_tip;
//top out
wire ie;
wire ass;


//top 内部处理 output to shift module
wire w_rx_negedge;
wire w_tx_negedge;
wire w_go;
wire w_char_len;
wire w_lsb;
wire w_latch;



always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_ctrl <= #Tp {`SPI_CTRL_BIT_NUM{1'b0}};
    else if(psi_ctrl_sel && i_write_en && !w_tip) begin
        if(i_byte_sel[0])
            r_ctrl[7:0] <= #Tp i_data[7:0] | {7'b0, r_ctrl[0]};
        if(i_byte_sel[1]
            r_ctrl[`SPI_CTRL_BIT_NUM-1:8] <= #Tp i_data[`SPI_CTRL_BIT_NUM-1:8];
    end
    else if(w_tip && w_last && w_pos_edge)
        r_ctrl[`SPI_CTRL_GO] <= #Tp 1'b0;
end

assign w_rx_negedge = r_ctrl[`SPI_CTRL_RX_NEGEDGE];
assign w_tx_negedge = r_ctrl[`SPI_CTRL_TX_NEGEDGE];
assign w_go = r_ctrl[`SPI_CTRL_GO];
assign w_char_len = r_ctrl[`SPI_CTRL_CHAR_LEN];
assign w_lsb = r_ctrl[`SPI_CTRL_LSB];
assign ie = r_ctrl[`SPI_CTRL_LSB];
assign ass = r_ctrl[`SPI_CTRL_ASS];
assign w_divider = r_divider;
assign o_pad_sclk = w_sclk;
assign w_latch = spi_tx_sel[3:0]&{4{i_write_en}};

always @(posedge i_clk or negedge i_rst_n) begin
    if(i_rst_n)
        r_divider = #Tp {`SPI_DIVIDER_LEN{1'b0}};
    else if(spi_divider_sel && i_write_en && !w_tip) begin
        `ifdef SPI_DIVIDER_LEN_8
            if(i_byte_sel[0])
                r_divider <= #Tp i_data[`SPI_DIVIDER_LEN-1:0];
        `endif
        `ifdef SPI_DIVIDER_LEN_16
            if(i_byte_sel[0])
                r_divider[7:0] <= #Tp i_data[7:0];
            if(i_byte_sel[1])
                r_divider[`SPI_DIVIDER_LEN-1:8] <= #Tp i_data[`SPI_DIVIDER_LEN-1:16];
        `endif
        `ifdef SPI_DIVIDER_LEN_24
            if(i_byte_sel[0])
                r_divider[7:0] <= #Tp i_data[7:0];
            if(i_byte_sel[1])
                r_divider[15:8] <= #Tp i_data[15:8];
            if(i_byte_sel[2])
                r_divider[`SPI_DIVIDER_LEN-1:16] <= #Tp i_data[`SPI_DIVIDER_LEN-1:16];
        `endif
        `ifdef SPI_DIVIDER_LEN_32
            if(i_byte_sel[0])
                r_divider[7:0] <= #Tp i_data[7:0];
            if(i_byte_sel[1])
                r_divider[15:8] <= #Tp i_data[15:8];
            if(i_byte_sel[2])
                r_divider[23:16] <= #Tp i_data[23:16];
            if(i_byte_sel[3])
                r_divider[`SPI_DIVIDER_LEN-1:24] <= #Tp i_data[`SPI_DIVIDER_LEN-1:24];
        `endif
    end
end

spi_clk_gen spi_clk_gen(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_enable   (w_tip),  //tx使能
    .i_tx_start (w_go),   //tx开始标志
    .i_last_clk (w_last), //tx传输完信号
    .i_divider  (w_divider),
    .o_clk_out  (w_sclk),  //o_pad_sclk
    .o_pos_edge (w_pos_edge),
    .o_neg_edge (w_neg_edge)
);
spi_shift spi_shift(
    .i_clk          (i_clk),
    .i_rst_n        (i_rst_n),
    .i_len          (w_char_len[`SPI_CHAR_LEN_BITS-1:0]),
    .i_latch        (w_latch),
    .i_byte_sel     (i_byte_sel), //wb_sel_i
    .i_lsb          (w_lsb),
    .i_go           (w_go),
    .i_pos_edge     (w_pos_edge),
    .i_neg_edge     (w_neg_edge),
    .i_rx_negedge   (w_rx_negedge),
    .i_tx_negedge   (w_tx_negedge),
    .i_parallel_in  (i_data),  //wb_dat_i
    .i_serial_in    (i_pad_miso),
    .i_serial_clk   (w_sclk),
    .o_tip          (w_tip),
    .o_last         (w_last),
    .o_parallel_out (rx_data), //rx to fpga reg
    .o_serial_out   (o_pad_mosi),
);
endmodule

