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

parameter Tp = 1;  
wire w_clk_out;
reg r_pos_edge;
reg r_neg_edge;

reg r_clk1;
reg r_clk2;  //奇数分频
reg r_clk3;  //偶数分频
reg [`SPI_DIVIDER_LEN-1:0] r_cnt1;
reg [`SPI_DIVIDER_LEN-1:0] r_cnt2;
reg [`SPI_DIVIDER_LEN-1:0] r_cnt3;
wire w_cnt1_one; //conter is equal to zero
wire w_cnt2_one; //conter is equal to one
wire w_clk0;   //system clk 的反时钟

assign w_cnt1_one = (r_cnt1 == {{`SPI_DIVIDER_LEN-1{1'b0}},1'b0});
assign w_cnt2_one = (r_cnt2 == {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1});

assign w_clk0 = ~i_clk;
assign w_clk_out = i_divider[0] ? (r_clk1 | r_clk3) : (r_clk1 | !r_clk2);

//clk1 主线
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk1 <= #Tp 1'b0;
        r_cnt1 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
    end
    //clk1 and clk2 是在传输信号启动后产生，传输结束就不再产生时钟
    else if(r_cnt1 == i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1}) //cnt 最大到 divider-1
    begin
        r_cnt1 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
        r_clk1 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk1 : r_clk1;  //或上一个w_clk_out的作用是将out_clk多输出一个系统时钟 之后置零
    end
    else if(i_divider[0] == 1'b1) begin //奇数分频
        if(r_cnt1 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})/2) begin
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk1 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk1 :r_clk1;
        end
        else
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
    else begin
        if(r_cnt1 == (i_divider/2)) begin
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk1 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk1 : r_clk1;
        end
        else
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
end

//clk2 偶数分频寄存器输出时钟
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_cnt2 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
        r_clk2 <= #Tp 1'b0;
    end
    else begin
        if(i_divider[0] == 1'b0) begin
            if(r_cnt2 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})) begin  //如果r_cnt2累加到 divider-1，归零
                r_cnt2 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
            end
            else if(r_cnt2 == {`SPI_DIVIDER_LEN{1'b0}}) begin   //如果r_cnt2累加到 0，r_clk2翻转一次
                r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
                r_clk2 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk2 : r_clk2; //(i_enable && (!i_last_clk || w_clk_out))
            end
            else if(r_cnt2 == ((i_divider/2)+1)) begin //如果r_cnt2累加到 divider/2+1，r_clk2翻转一次
                r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
                r_clk2 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk2 : r_clk2;
            end
            else begin  //如果以上条件均未达到 r_cnt2继续累加
                r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
                r_clk2 <= #Tp r_clk2;
            end   
        end
        else begin //如果当前不是偶数分频 r_cnt2 r_clk2 归零
            r_cnt2 <= #Tp {`SPI_DIVIDER_LEN{1'b0}}; 
            r_clk2 <= #Tp 1'b0;          
        end
    end
end
//clk3 奇数分频寄存器输出时钟
always @(posedge w_clk0 or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk3 <= #Tp 1'b0;
        r_cnt3 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
    end
    else if(r_cnt3 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})) begin
        r_cnt3 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
        r_clk3 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk3 : r_clk3;
    end
    else if(i_divider[0] == 1'b1) begin //如果是奇数分频
        if(r_cnt3 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})/2) begin
            r_cnt3 <= #Tp r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk3 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk3 : r_clk3;
        end
        else
            r_cnt3 <= #Tp r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
    else begin
        if(r_cnt3 == i_divider/2) begin
            r_cnt3 <= #Tp r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk3 <= #Tp (i_enable && (!i_last_clk || w_clk_out)) ? ~r_clk3 : r_clk3;
        end
        else
            r_cnt3 <= #Tp r_cnt3 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_pos_edge <= #Tp 1'b0;
        r_neg_edge <= #Tp 1'b0;
    end
    else begin
        r_pos_edge <= #Tp (i_enable && !w_clk_out && w_cnt2_one) || (!(|i_divider) && w_clk_out) || (!(|i_divider) && i_tx_start && !i_enable);
        r_neg_edge <= #Tp (i_enable && w_clk_out && w_cnt1_one) || (!(|i_divider) && !w_clk_out && i_enable);
    end
end

assign o_clk_out = w_clk_out;
assign o_pos_edge = r_pos_edge;
assign o_neg_edge = r_neg_edge;
endmodule // spi_clk_geninput       i_clk,

