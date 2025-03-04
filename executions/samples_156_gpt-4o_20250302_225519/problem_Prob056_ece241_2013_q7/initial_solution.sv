module TopModule (
    input logic clk,   // Clock signal, assumed to trigger on positive edge
    input logic j,     // J input for JK flip-flop
    input logic k,     // K input for JK flip-flop
    output logic Q     // Output Q of the JK flip-flop
);

    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;    // Retain state
            2'b01: Q <= 1'b0; // Reset
            2'b10: Q <= 1'b1; // Set
            2'b11: Q <= ~Q;   // Toggle
        endcase
    end

endmodule