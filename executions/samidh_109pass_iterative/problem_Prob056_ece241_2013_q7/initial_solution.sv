module TopModule (
    input logic clk,  // Clock signal
    input logic j,    // J input of the JK flip-flop
    input logic k,    // K input of the JK flip-flop
    output logic Q    // Registered output of the JK flip-flop
);

    always_ff @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;         // Retain previous state
            2'b01: Q <= 1'b0;      // Reset to 0
            2'b10: Q <= 1'b1;      // Set to 1
            2'b11: Q <= ~Q;        // Toggle state
            default: Q <= Q;       // Default case for safety
        endcase
    end

endmodule