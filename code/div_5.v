module div_5(
    input   i_clk,
    input   i_rst_n,
    output  o_clk_5
);
reg r_clk_5;
reg r_clk_5_tmp;
reg [2:0] r_current_state;
reg [2:0] r_next_state

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b011;
parameter S3 = 3'b010;
parameter S4 = 3'b110;

always @(current_state) begin
    case (current_state)
        S0:begin
            r_clk_5_tmp = 0;
            r_next_state = S1;
        end
        S1:begin
            r_clk_5_tmp = 0;
            r_next_state = S2;
        end
        S2:begin
            r_clk_5_tmp = 1;
            r_next_state = S3;
        end
        S3:begin
            r_clk_5_tmp = 1;
            r_next_state = S4;
        end
        S4:begin
            r_clk_5_tmp = 1;
            r_next_state = S0
        end
        default:begin
            r_clk_5_tmp = 0;
            r_next_state = S0;
        end
    endcase
end

always @(posedge i_clk or i_rst_n) begin
    if(!i_rst_n)
        current_state <= S0;
    else begin
        r_clk_5 <= r_clk_5_tmp
        current_state <= r_next_state;
    end
end
endmodule // div_5
