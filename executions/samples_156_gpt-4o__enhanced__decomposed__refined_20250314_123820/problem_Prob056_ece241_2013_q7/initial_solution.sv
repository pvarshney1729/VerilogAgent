[BEGIN]
module TopModule (
    input logic clk,    // Clock signal, positive-edge triggered
    input logic j,      // J input, 1-bit
    input logic k,      // K input, 1-bit
    input logic rst_n,  // Active-low reset, 1-bit
    output logic Q      // Q output, 1-bit, holds the state of the flip-flop
);

always @(posedge clk) begin
    if (!rst_n) begin
        Q <= 1'b0; // Synchronous reset logic
    end else begin
        case ({j, k})
            2'b00: Q <= Q;      // No change
            2'b01: Q <= 1'b0;   // Reset
            2'b10: Q <= 1'b1;   // Set
            2'b11: Q <= ~Q;     // Toggle
        endcase
    end
end

endmodule
[DONE]