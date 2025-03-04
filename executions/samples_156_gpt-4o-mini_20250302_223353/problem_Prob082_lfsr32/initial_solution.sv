module TopModule (
    input logic clk,               // Clock input, triggering on positive edge
    input logic reset,             // Active high synchronous reset
    output logic [31:0] q          // 32-bit output register
);

// Initial State and Reset Behavior
// On reset (active high), output q is reset to 32'h1. When reset is de-asserted, the LFSR resumes normal operation.
initial begin
    q = 32'h1;
end

// LFSR Tap Positions
// Taps are at bit positions: 32, 22, 2, and 1 (1-indexed as per convention).
// The feedback mechanism uses XOR operations with these taps and the current LSB (q[0]).

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1; // Reset state
    end else begin
        // Feedback calculation: New MSB is the XOR of specified taps with q[0]
        logic feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
        q <= {q[30:0], feedback}; // Shift right and insert feedback as the new MSB
    end
end

endmodule