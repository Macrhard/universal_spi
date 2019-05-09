`include "define.v"
module spi_shift(
    input       i_clk, //system clk
    input       i_rst_n,
    input [3:0] i_latch,                  //锁存器信号 分别对应低到高四个32bit寄存器
    input [3:0] i_byte_sel,               //字节选择信号 四位分别对应寄存器的由高到低四个字节
    input [`SPI_CHAR_LEN_BITS-1:0] i_len, //数据位长信号
    input       i_lsb,
    input       i_go,                     //开始传输信号
    input       i_pos_edge,               //sclk 上升沿信号
    input       i_neg_edge,               //sclk下降沿信号
    input       i_rx_negedge,             //串行输入在时钟下降沿采样
    input       i_tx_negedge,             //串行输出在时钟上升沿发送
    input [31:0] i_parallel_in,           //并行输入 mcu to spi
    input       i_serial_in,              //miso 串行输入
    input       i_serial_clk,             //sclk
    output      o_tip,                    //传输进行信号，连接到spi_clk_gen中i_enable
    output      o_last,                   //提示传输最后一位
    output [`SPI_CHAR_LEN_BITS-1:0] o_parallel_out, //并行输出，输出到muc
    output      o_serial_out              //mosi 串行输出
);
parameter Tp = 0; 
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
            r_cnt <= #Tp i_pos_edge ? (r_cnt - {{`SPI_CHAR_LEN_BITS{1'b0}},1'b1}) : r_cnt; //传输进行时，在sclk的上升沿减1，否则保持
        else  
            r_cnt <= #Tp !(|i_len) ? {1'b1,{`SPI_CHAR_LEN_BITS{1'b0}}} : {1'b0,i_len}; //未传输时，载入len，当len全为0即最大传输128bit，赋cnt=8'h80;否则cnt =len
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

//串行数据输出
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_serial_out <= #Tp 1'b0;
    else
        r_serial_out <= #Tp(w_tx_clk_en || !r_tip) ? r_data[w_tx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]] : r_serial_out;
end

//并行数据输入
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n)
        r_data <= #Tp {`SPI_MAX_CHAR{1'b0}};
`ifdef SPI_MAX_CHAR_128
    else if(i_latch[0] && !r_tip) begin  //锁存使能，并行输入开始，每次并行传输32bit
        if(i_byte_sel[3])                //shift位选择信号，每次并行传输8bit
            r_data[31:24] <= #Tp i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[23:16] <= #Tp i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[15:8] <= #Tp i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[7:0] <= #Tp i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
    else if(i_latch[1] && !r_tip) begin
        if(i_byte_sel[3])
            r_data[63:56] <= #Tp i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[55:48] <= i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[47:40] <= i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[39:32] <= i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
    else if(i_latch[2] && !r_tip) begin
        if(i_byte_sel[3])
            r_data[95:88] <= i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[87:80] <= i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[79:72] <= i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[71:64] <= i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
    else if(i_latch[3] && !r_tip) begin
        if(i_byte_sel[3])
            r_data[127:120] <= i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[119:112] <= i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[111:104] <= i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[103:96] <= i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
`endif
`ifdef SPI_MAX_CHAR_64
    else if(i_latch[0] && !r_tip) begin  //锁存使能，并行输入开始，每次并行传输32bit
        if(i_byte_sel[3])                //shift位选择信号，每次并行传输8bit
            r_data[31:24] <= #Tp i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[23:16] <= #Tp i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[15:8] <= #Tp i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[7:0] <= #Tp i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
    else if(i_latch[1] && !r_tip) begin
        if(i_byte_sel[3])
            r_data[63:56] <= #Tp i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[55:48] <= i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[47:40] <= i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[39:32] <= i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
`endif
`ifdef SPI_MAX_CHAR_32
    else if(i_latch[0] && !r_tip) begin  //锁存使能，并行输入开始，每次并行传输32bit
        if(i_byte_sel[3])                //shift位选择信号，每次并行传输8bit
            r_data[31:24] <= #Tp i_parallel_in[31:24];
        else if(i_byte_sel[2])
            r_data[23:16] <= #Tp i_parallel_in[23:16];
        else if(i_byte_sel[1])
            r_data[15:8] <= #Tp i_parallel_in[15:8];
        else if(i_byte_sel[0])
            r_data[7:0] <= #Tp i_parallel_in[7:0];
        else
            i_parallel_in <= i_parallel_in;
    end
`endif
`ifdef SPI_MAX_CHAR_24
    else if(i_byte_sel[0])
        r_data[7:0] <= #Tp i_parallel_in[7:0];
    else if(i_byte_sel[1])
        r_data[15:8] <= #Tp i_parallel_in[15:8];
    else if(i_byte_sel[2])
        r_data[23:16] <= #Tp i_parallel_in[23:16];
    else if(i_byte_sel[3])
        r_data[`SPI_MAX_CHAR-1:24] <= #Tp i_parallel_in[`SPI_MAX_CHAR-1:24];
`endif
end
`endif
`endif
    else //否则在不进行并行输入时，串行输入或者保持数据
        r_data[w_rx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]] <= #Tp w_rx_clk_en ? i_serial_in : r_data[w_rx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]];
end
endmodule // spi_shift