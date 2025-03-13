[BEGIN]
module TopModule(
    input  logic [7:0] code,   // 8-bit input for keyboard scancode
    output logic [3:0] out,    // 4-bit output representing the key number
    output logic valid          // 1-bit output indicating recognition of a valid scancode
);

always @(*) begin
    valid = 1'b0; // Default value for valid
    out = 4'b0000; // Default value for out
    
    case (code)
        8'h45: begin
            out = 4'b0000; // 0
            valid = 1'b1;
        end
        8'h16: begin
            out = 4'b0001; // 1
            valid = 1'b1;
        end
        8'h1e: begin
            out = 4'b0010; // 2
            valid = 1'b1;
        end
        8'h26: begin
            out = 4'b0011; // 3
            valid = 1'b1;
        end
        8'h25: begin
            out = 4'b0100; // 4
            valid = 1'b1;
        end
        8'h2e: begin
            out = 4'b0101; // 5
            valid = 1'b1;
        end
        8'h36: begin
            out = 4'b0110; // 6
            valid = 1'b1;
        end
        8'h3d: begin
            out = 4'b0111; // 7
            valid = 1'b1;
        end
        8'h3e: begin
            out = 4'b1000; // 8
            valid = 1'b1;
        end
        8'h46: begin
            out = 4'b1001; // 9
            valid = 1'b1;
        end
        default: begin
            out = 4'b0000;
            valid = 1'b0;
        end
    endcase
end

endmodule
[DONE]