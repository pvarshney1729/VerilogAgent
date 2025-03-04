```verilog
module TopModule (
    input logic clk,  // Clock signal, active on the rising edge
    input logic j,    // J input of the JK flip-flop, 1-bit, unsigned
    input logic k,    // K input of the JK flip-flop, 1-bit, unsigned
    output logic Q    // Output of the JK flip-flop, 1-bit, unsigned
);

    // Initialize Q to 0 at power-up or simulation start
    initial begin
        Q = 1'b0;
    end

    // JK flip-flop behavior on rising edge of clk
    always_ff @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;         // Retain previous state
            2'b01: Q <= 1'b0;      // Reset to 0
            2'b10: Q <= 1'b1;      // Set to 1
            2'b11: Q <= ~Q;        // Toggle state
            default: Q <= Q;       // Default case to retain state
        endcase
    end

endmodule
```