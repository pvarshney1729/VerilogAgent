module TopModule(
    input logic clk,
    input logic j,
    input logic k,
    output logic Q
);

    // Initial state for simulation purposes
    initial begin
        Q = 1'b0;
    end

    // JK Flip-Flop behavior with synchronous reset
    always_ff @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;          // Retain state
            2'b01: Q <= 1'b0;       // Reset
            2'b10: Q <= 1'b1;       // Set
            2'b11: Q <= ~Q;         // Toggle
            default: Q <= Q;        // Default case for safety
        endcase
    end

endmodule