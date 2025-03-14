module TopModule (
    input wire [7:0] code,      // 8-bit input representing keyboard scan codes (unsigned)
    input wire reset,           // Synchronous reset signal
    output reg [3:0] out,       // 4-bit output representing detected key (0-9)
    output reg valid             // 1-bit output indicating recognition of valid key
);

always @(posedge reset or code) begin
    if (reset) begin
        out <= 4'b0000;
        valid <= 1'b0;
    end else begin
        case (code)
            8'h45: begin out <= 4'b0000; valid <= 1'b1; end
            8'h16: begin out <= 4'b0001; valid <= 1'b1; end
            8'h1e: begin out <= 4'b0010; valid <= 1'b1; end
            8'h26: begin out <= 4'b0011; valid <= 1'b1; end
            8'h25: begin out <= 4'b0100; valid <= 1'b1; end
            8'h2e: begin out <= 4'b0101; valid <= 1'b1; end
            8'h36: begin out <= 4'b0110; valid <= 1'b1; end
            8'h3d: begin out <= 4'b0111; valid <= 1'b1; end
            8'h3e: begin out <= 4'b1000; valid <= 1'b1; end
            8'h46: begin out <= 4'b1001; valid <= 1'b1; end
            default: begin out <= 4'b0000; valid <= 1'b0; end
        endcase
    end
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly