`include "../code/define.v"
`timescale 1ns/1ps
module clk_gen_top_tb();

reg i_clk;
reg i_rst_n;
reg i_enable;
reg i_tx_start;
reg i_last_clk;
reg [`SPI_DIVIDER_LEN-1:0] r_divider;
wire w_clk_out;
wire w_pos_edge;
wire w_neg_edge;
wire w_last;
wire w_tip;
reg r_go; //tx send enable
reg wb_we_i; //输入数据的写使能
reg wb_clk_i;
reg wb_rst_i; //高电平有效
reg [4:0]  wb_adr_i; //低地址位
reg [31:0] wb_dat_i; //SPI core 的输入数据
reg [31:0] wb_dat_o; //SPI core 的输出数据
reg [3:0]  wb_sel_i; //字节选择信号
reg [7:0] r_len;
reg r_lsb;
reg [31:0] r_parallel_in;
reg r_serial_in;
wire [`SPI_CHAR_LEN_BITS-1:0] w_parallel_out;
wire w_serial_out;
wire 

spi_clk_gen spi_clk_gen(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_enable   (w_tip),
    .i_tx_start (r_go),
    .i_last_clk (w_last),
    .i_divider  (r_divider),
    .o_clk_out  (w_clk_out),
    .o_pos_edge (w_pos_edge),
    .o_neg_edge (w_neg_edge)
);

spi_shift spi_shift(
    .i_clk      (i_clk),
    .i_rst_n    (i_rst_n),
    .i_latch    (spi_tx_sel[3:0]&{4{wb_we_i}}),
    .i_byte_sel (wb_sel_i),
    .i_len      (r_len),
    .i_lsb      (r_lsb),
    .i_go       (r_go),
    .i_pos_edge (w_pos_edge),
    .i_neg_edge (w_neg_edge),
    .i_parallel_in  (r_parallel_in),
    .i_serial_in    (r_serial_in),
    .i_serial_clk   (w_clk_out),
    .o_tip          (w_tip),
    .o_last         (w_last),
    .o_parallel_out (w_parallel_out),
    .o_serial_out   (w_serial_out),
);

initial begin
                i_clk = 1'b0;
                i_enable = 1'b1;
                i_last_clk = 1'b0;
                r_divider = 8'd2;
                i_tx_start = 1'b1;
    #10         i_rst_n = 1'b0;
    #50         i_rst_n = 1'b1;
    #300        r_divider = 8'd12;
    #300        r_divider = 8'd3;
    #300        r_divider = 8'd6;
    #300        r_divider = 8'd5;
    #300        r_divider = 8'd4;
    #300        r_divider = 8'd7;
                i_enable = 1'b1;
    #50         i_enable = 1'b1;
    #300        r_divider = 8'd6;
    #300        r_divider = 8'd10;
    #300        r_divider = 8'd2;
    #300        r_divider = 8'd4;
    #300        i_last_clk = 1'b1;
    #300        r_divider = 8'd6;
                i_last_clk = 1'b0;
    #300        r_divider = 8'd2;
end

always #1 i_clk = ~i_clk;
//always #40 i_clk = ~i_clk;
endmodule



wb_clk_i;
wb_wb_rst_i;
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

