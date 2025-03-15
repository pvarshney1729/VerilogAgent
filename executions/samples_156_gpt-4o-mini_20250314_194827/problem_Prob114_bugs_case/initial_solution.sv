module TopModule (
    input logic [7:0] code,
    input logic clk,
    input logic reset,
    output logic [3:0] out,
    output logic valid
);

    always @(*) begin
        if (reset) begin
            out = 4'b0000;
            valid = 1'b0;
        end else begin
            case (code)
                8'b00000000: begin out = 4'b0000; valid = 1'b1; end
                8'b00000001: begin out = 4'b0001; valid = 1'b1; end
                8'b00000010: begin out = 4'b0010; valid = 1'b1; end
                8'b00000011: begin out = 4'b0011; valid = 1'b1; end
                8'b00000100: begin out = 4'b0100; valid = 1'b1; end
                8'b00000101: begin out = 4'b0101; valid = 1'b1; end
                8'b00000110: begin out = 4'b0110; valid = 1'b1; end
                8'b00000111: begin out = 4'b0111; valid = 1'b1; end
                8'b00001000: begin out = 4'b1000; valid = 1'b1; end
                8'b00001001: begin out = 4'b1001; valid = 1'b1; end
                8'b00001010: begin out = 4'b1010; valid = 1'b1; end
                8'b00001011: begin out = 4'b1011; valid = 1'b1; end
                8'b00001100: begin out = 4'b1100; valid = 1'b1; end
                8'b00001101: begin out = 4'b1101; valid = 1'b1; end
                8'b00001110: begin out = 4'b1110; valid = 1'b1; end
                8'b00001111: begin out = 4'b1111; valid = 1'b1; end
                default: begin out = 4'b0000; valid = 1'b0; end
            endcase
        end
    end

endmodule