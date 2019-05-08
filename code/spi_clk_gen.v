`include "define.v"
//`define SPI_DIVIDER_LEN 8
module spi_clk_gen(
    input       i_clk,  //system clk
    input       i_rst_n, //low reset
    input       i_enable, //clk gen enable
    input       i_tx_start, //start transfer
    input       i_last_clk, //last clk
    input [`SPI_DIVIDER_LEN-1:0] i_divider, //clk divider
    output      o_clk_out, //output clk
    output      o_pos_edge, //pluse marking positive edge of clk_out
    output      o_neg_edge //pluse marking negative edge of clk_out
);

parameter Tp = 0;  

reg test_pos_1;
reg test_pos_3;

reg r_pos_edge_1;   //偶数分频上升沿 clk1上升沿
reg r_pos_edge_3;   //奇数分频上升沿 clk3上升沿
reg r_neg_edge_1;   //奇数分频下降沿 clk1下降沿
reg r_neg_edge_2;   //偶数分频下降沿 clk2下降沿


reg r_clk1; 
reg r_clk2;  //奇数分频
reg r_clk3;  //偶数分频
reg [`SPI_DIVIDER_LEN-1:0] r_cnt1;
reg [`SPI_DIVIDER_LEN-1:0] r_cnt2;
reg [`SPI_DIVIDER_LEN-1:0] r_cnt3;

wire w_clk0;   //system clk 的反时钟
assign w_clk0 = ~i_clk;

//clk1 主线
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk1 <=  1'b0;
        r_cnt1 <=  {`SPI_DIVIDER_LEN{1'b0}};
        r_pos_edge_1 <= 1'b0;
        r_neg_edge_1 <= 1'b0;
        test_pos_1 <= 1'b0;
    end
    //clk1 2 3是在传输信号启动后产生，传输结束就不再产生时钟 //但cnt 1 2 3 仍要计数
    else if(r_cnt1 >= i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1}) //cnt 最大到 divider-1
    begin
        r_cnt1 <=  {`SPI_DIVIDER_LEN{1'b0}};
        r_clk1 <=  (i_enable && (!i_last_clk)) ? 1'b0 : 1'b0;  //或上一个w_clk_out的作用是将out_clk多输出一个系统时钟 之后置零
        r_pos_edge_1 <=  1'b0; //ok
        r_neg_edge_1 <=  1'b1;
    end
    else if(i_divider[0] == 1'b1) begin //奇数分频
        if(r_cnt1 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})/2) begin
            r_cnt1 <=  r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk1 <=  (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
            r_pos_edge_1 <= 1'b1;
            r_neg_edge_1 <= 1'b0;
        end
        else begin
            r_cnt1 <=  r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_pos_edge_1 <= 1'b0;
            r_neg_edge_1 <= 1'b0;
        end  
    end
    else begin
        if(r_cnt1 == (i_divider/2)) begin
            r_cnt1 <= r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk1 <= (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
            r_pos_edge_1 <= 1'b1;
            r_neg_edge_1 <= 1'b1;
            test_pos_1 <= 1'b1; 
        end
        else
            r_cnt1 <=  r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_pos_edge_1 <= 1'b0;
            r_neg_edge_1 <= 1'b0;
            test_pos_1 <= 1'b0;
    end
end

//clk2 偶数分频寄存器输出时钟  记录下降沿
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk2 <=  1'b0;
        r_cnt2 <=  {`SPI_DIVIDER_LEN{1'b0}};
        r_neg_edge_2 <=  1'b0;
    end
    else if(i_divider == 'd2) begin //添加2分频
        if(r_cnt2 >= i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1}) begin
            r_cnt2 <=  {`SPI_DIVIDER_LEN{1'b0}};
            r_clk2 <=  (i_enable && (!i_last_clk)) ? r_clk2 + 1'b1 : 1'b0;
            r_neg_edge_2 <=  (i_enable && (!i_last_clk)) ? r_neg_edge_2 +1'b1 : 1'b0;
        end
        else begin
            r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk2 <=  (i_enable && (!i_last_clk)) ? r_clk2 + 1'b1 : 1'b0;
            r_neg_edge_2 <=  (i_enable && (!i_last_clk)) ? r_neg_edge_2 +1'b1 : 1'b0;
        end
    end
    else if(i_divider == 'd4) begin  //修复4分频bug
        if(r_cnt2 == {`SPI_DIVIDER_LEN{1'b0}}) begin
            r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk2 <=  (i_enable && (!i_last_clk)) ? 1'b0 : 1'b0;
            r_neg_edge_2 <=  (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
        end
        else if(r_cnt2 >= (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})) begin
            r_cnt2 <=  {`SPI_DIVIDER_LEN{1'b0}};
            r_clk2 <=  (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
            r_neg_edge_2 <=  1'b0;
        end
        else 
            r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_neg_edge_2 <=  1'b0;
    end
    else if(r_cnt2 == {`SPI_DIVIDER_LEN{1'b0}}) begin
        r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
        r_clk2 <=  (i_enable && (!i_last_clk)) ? 1'b0 : 1'b0;
        r_neg_edge_2 <=  (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
    end
    else if(r_cnt2 >= (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})) begin
        r_cnt2 <=  {`SPI_DIVIDER_LEN{1'b0}};
        r_neg_edge_2 <=  1'b0;
    end
    else if(i_divider[0] == 1'b0) begin //如果是偶数分频
        if(r_cnt2 == ((i_divider/2)+1)) begin
            r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk2 <=  (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
            r_neg_edge_2 <=  1'b0;
        end
        else begin
            r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_neg_edge_2 <=  1'b0;
        end    
    end
    else begin
        r_cnt2 <=  r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1}; //保持计数
        r_clk2 <=  1'b0;
        r_neg_edge_2 <= 1'b0;
    end
end

//clk3 奇数分频寄存器输出时钟
always @(posedge w_clk0 or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk3 <=  1'b0;
        r_cnt3 <=  {`SPI_DIVIDER_LEN{1'b0}};
        r_pos_edge_3 <=  1'b0;
        test_pos_3 <= 1'b0;
    end
    else if(r_cnt3 >= (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})) begin
        r_cnt3 <=  {`SPI_DIVIDER_LEN{1'b0}};
        r_clk3 <=  (i_enable && (!i_last_clk)) ? 1'b0 : 1'b0;
        r_pos_edge_3 <= 1'b0;
    end
    else if(i_divider[0] == 1'b1) begin //如果是奇数分频
        if(r_cnt3 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})/2) begin
            r_cnt3 <=  r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk3 <=  (i_enable && (!i_last_clk)) ? 1'b1 : 1'b0;
            r_pos_edge_3 <=  1'b1;
            test_pos_3 <= 1'b1;
        end
        else begin
            r_cnt3 <=  r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_pos_edge_3 <=  1'b0;
        end  
    end
    else begin
        r_cnt3 <=  r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
        r_clk3 <=  1'b0;
        r_pos_edge_3 <=  1'b0;
        test_pos_3 <= 1'b1;
    end
end

/*
wire w_cnt1_zero; //conter is equal to zero
wire w_cnt2_one; //conter is equal to one
assign w_cnt1_zero = (r_cnt1 == {{`SPI_DIVIDER_LEN-1{1'b0}},1'b0});
assign w_cnt2_max = (r_cnt2 == {{`SPI_DIVIDER_LEN-1{1'b0}},1'b0});

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_pos_edge <=  1'b0;
        r_neg_edge_2 <=  1'b0;
    end
    else begin
        r_pos_edge <=  (i_enable && !w_clk_out && w_cnt2_one) || (!(|i_divider) && w_clk_out) || (!(|i_divider) && i_tx_start && !i_enable);
        r_neg_edge_2 <=  (i_enable && w_clk_out && w_cnt1_zero) || (!(|i_divider) && !w_clk_out && i_enable);
    end
end
*/

assign o_clk_out = i_divider[0] ? (r_clk1 | r_clk3) : (r_clk1 | r_clk2);
assign o_pos_edge = i_divider[0] ? r_pos_edge_3 : r_pos_edge_1;
assign o_neg_edge = i_divider[0] ? r_neg_edge_1 : r_neg_edge_2;
endmodule 
