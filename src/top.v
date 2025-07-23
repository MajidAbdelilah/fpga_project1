module top(
            input clk,
            output a, b, c, d, e, f, g, sel
        );
    reg [31:0] clk_counter = 32'b0;
    reg [7:0] c1_reg = 8'b0;
    always@(posedge clk) begin
        clk_counter = (clk_counter + 32'b1) & { 32 { !(!( clk_counter ^ 32'd5000000 )) } };
        c1_reg[7:4] = (c1_reg[7:4] + (!(c1_reg[3:0] ^ 8'd10)) ) & { 4 { !(!(c1_reg[7:4] ^ 8'd10)) } };
        c1_reg[3:0] = (c1_reg[3:0] + !clk_counter) & { 4 { !(!(c1_reg[3:0] ^ 8'd10)) } };
        
    end

    decimal_1_counter_pmod c1(a, b, c, d, e, f, g, sel, c1_reg[7:0], clk);


endmodule


module decimal_1_counter_pmod(
            output reg a, b, c, d, e, f, g, sel,
            input [7:0] num,
            input clk
);
    reg [15:0]clk_counter = 0;

    always@(posedge clk) begin
         a = 1; b = 1; c = 1; d = 1; e = 1; f = 1; g = 1;
         if(clk_counter < 16'b1000000000000000) begin
            sel = 1;
            case(num[3:0])
                4'd0: begin a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; end
                4'd1: begin b = 0; c = 0; end
                4'd2: begin a = 0; b = 0; g = 0; e = 0; d = 0; end
                4'd3: begin a = 0; b = 0; c = 0; d = 0; g = 0; end
                4'd4: begin f = 0; b = 0; c = 0; g = 0; end
                4'd5: begin a = 0; f = 0; g = 0; c = 0; d = 0; end
                4'd6: begin a = 0; c = 0; d = 0; e = 0; f = 0; g = 0; end
                4'd7: begin a = 0; b = 0; c = 0;  end
                4'd8: begin a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; g = 0; end
                4'd9: begin a = 0; b = 0; c = 0; d = 0; f = 0; g = 0; end
                default: begin a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; end
            endcase
        end
        else begin
            sel = 0;
            case(num[7:4])
                4'd0: begin a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; end
                4'd1: begin b = 0; c = 0; end
                4'd2: begin a = 0; b = 0; g = 0; e = 0; d = 0; end
                4'd3: begin a = 0; b = 0; c = 0; d = 0; g = 0; end
                4'd4: begin f = 0; b = 0; c = 0; g = 0; end
                4'd5: begin a = 0; f = 0; g = 0; c = 0; d = 0; end
                4'd6: begin a = 0; c = 0; d = 0; e = 0; f = 0; g = 0; end
                4'd7: begin a = 0; b = 0; c = 0;  end
                4'd8: begin a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; g = 0; end
                4'd9: begin a = 0; b = 0; c = 0; d = 0; f = 0; g = 0; end
                default: begin a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; end
            endcase
        end
        clk_counter = clk_counter + 16'b1;
    end


endmodule
