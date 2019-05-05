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

reg r_clk_out;
reg r_pos_edge;
reg r_neg_edge;

reg r_clk1;
reg r_clk2;
reg [`SPI_DIVIDER_LEN-1:0] r_cnt1;
reg [`SPI_DIVIDER_LEN-1:0] r_cnt2;
wire w_cnt1_one; //conter is equal to zero
wire w_cnt2_one; //conter is equal to one
wire w_clk0;

assign w_cnt1_one = (r_cnt1 =={{`SPI_DIVIDER_LEN-1{1'b0}},1'b1});
assign w_cnt2_one = (r_cnt2 =={{`SPI_DIVIDER_LEN-1{1'b0}},1'b1});

assign w_clk0 = ~i_clk
assign o_clk_out = r_clk1 | r_clk2

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk1 <= #Tp 1'b0;
        r_cnt1 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
    end
    //clk1 and clk2 是在传输信号启动后产生，传输结束就不再产生时钟
    else if(r_cnt1 == i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})
    begin
        r_cnt1 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
        r_clk1 <= #Tp (i_enable && (!i_last_clk || r_clk_out)) ? ~r_clk1 : r_clk1;
    end
    else if(i_divider[0] == 1'b1) begin
        if(r_cnt1 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})/2) begin
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk1 <= #Tp (i_enable && (!i_last_clk || r_clk_out)) ? ~r_clk1 :r_clk1;
        end
        else
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
    else begin
        if(r_cnt1 == (i_divider/2)) begin
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk1 <= #Tp (i_enable && (!i_last_clk || r_clk_out)) ? ~r_clk1 : r_clk1;
        end
        else
            r_cnt1 <= #Tp r_cnt1 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_clk2 <= #Tp 1'b0;
        r_cnt2 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
    end
    else if(r_cnt2 == (i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1})) begin
        r_cnt2 <= #Tp {`SPI_DIVIDER_LEN{1'b0}};
        r_clk2 <= #Tp (i_enable && (!i_last_clk || r_clk_out)) ? ~r_clk2 : r_clk2;
    end
    else if(i_divider[0] == 1'b1) begin
        if(r_cnt2 == i_divider-{{`SPI_DIVIDER_LEN-1{1'b0}},1'b1}/2) begin
            r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk2 <= #Tp (i_enable && (!i_last_clk || r_clk_out)) ? ~r_clk2 : r_clk2;
        end
        else
            r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
    else begin
        if(r_cnt2 == i_divider/2) begin
            r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
            r_clk2 <= #Tp (i_enable && (!i_last_clk || r_clk_out)) ? ~r_clk2 : r_clk2;
        end
        else
            r_cnt2 <= #Tp r_cnt2 + {{`SPI_DIVIDER_LEN-1{1'b0}},1'b1};
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_pos_edge <= #Tp 1'b0;
        r_neg_edge <= #Tp 1'b0;
    end
    else begin
        r_pos_edge <= #Tp (i_enable && !r_clk_out && w_cnt2_one) || (!(|i_divider) && r_clk_out) || (!(|i_divider) && i_tx_start && !i_enable);
        r_neg_edge <= #Tp (i_enable && r_clk_out && w_cnt1_one) || (!(|i_divider) && !r_clk_out && i_enable);
    end
end

assign o_clk_out = r_clk_out;
assign o_pos_edge = r_pos_edge;
assign o_neg_edge = r_neg_edge;
endmodule // spi_clk_geninput       i_clk,
