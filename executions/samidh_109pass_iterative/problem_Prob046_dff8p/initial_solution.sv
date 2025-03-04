module TopModule (
    input logic clk,              // Clock signal, active on the negative edge for flip-flop triggering
    input logic reset,            // Active high reset signal
    input logic [7:0] d,          // 8-bit data input
    output logic [7:0] q          // 8-bit data output
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'b00110100;  // Reset state: 0x34
    end else begin
        q <= d;            // Capture input
    end
end

endmodule