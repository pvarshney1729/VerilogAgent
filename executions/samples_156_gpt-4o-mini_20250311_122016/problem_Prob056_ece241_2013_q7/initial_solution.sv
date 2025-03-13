[BEGIN]
```verilog
module TopModule (
    input logic clk,    // Clock signal, positive-edge triggered
    input logic j,      // J input, active high
    input logic k,      // K input, active high
    output logic Q      // Q output, initially 0 (reset state)
);

    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;      // Retain previous state
            2'b01: Q <= 1'b0;   // Reset
            2'b10: Q <= 1'b1;   // Set
            2'b11: Q <= ~Q;     // Toggle
            default: Q <= Q;    // Default case (should not occur)
        endcase
    end

    initial begin
        Q = 1'b0; // Initialize Q to 0
    end

endmodule
```
[DONE]