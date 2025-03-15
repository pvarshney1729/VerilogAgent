module TopModule (
    input logic clk,            // Clock input, active on negative edge
    input logic reset,          // Active high synchronous reset
    input logic [7:0] d,        // 8-bit data input, unsigned
    output logic [7:0] q         // 8-bit data output, unsigned
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'h34;            // Set output to 0x34 on reset
    end else begin
        q <= d;                // Capture input data on negative edge
    end
end

endmodule