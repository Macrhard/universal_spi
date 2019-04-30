module (
    input   [7:0]   i_div_sel,
    input           i_clk,
    input           i_rst_n,
    output          o_div_clk
);

reg [7:0]   div_cnt;
always @(posedge i_clk or negedge i_rst_n)
begin
    if (!i_rst_n) begin
        div_cnt <= 'd0;
    else
        div_cnt <= div_cnt + 'b1;
    end
end

reg r_div_sel_sck;
always @(posedge i_clk or negedge i_rst_n)
begin
    if(!i_rst_n)begin
        r_div_sel_sck <= 'd0;
    else
        r_div_sel_sck <= div_cnt[i_div_sel];
    end
end

assign o_div_clk = r_div_sel_sck;
endmodule // 