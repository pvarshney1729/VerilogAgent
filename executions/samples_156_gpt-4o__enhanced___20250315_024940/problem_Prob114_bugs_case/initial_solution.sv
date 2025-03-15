module TopModule (
    input logic [7:0] code,
    output logic [3:0] out,
    output logic valid
);
    always @(*) begin
        case (code)
            8'h45: begin out = 4'b0000; valid = 1; end // Key 0
            8'h16: begin out = 4'b0001; valid = 1; end // Key 1
            8'h1e: begin out = 4'b0010; valid = 1; end // Key 2
            8'h26: begin out = 4'b0011; valid = 1; end // Key 3
            8'h25: begin out = 4'b0100; valid = 1; end // Key 4
            8'h2e: begin out = 4'b0101; valid = 1; end // Key 5
            8'h36: begin out = 4'b0110; valid = 1; end // Key 6
            8'h3d: begin out = 4'b0111; valid = 1; end // Key 7
            8'h3e: begin out = 4'b1000; valid = 1; end // Key 8
            8'h46: begin out = 4'b1001; valid = 1; end // Key 9
            default: begin out = 4'b0000; valid = 0; end // No valid key
        endcase
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly