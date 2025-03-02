module TopModule (
    input logic clk,  // Clock signal
    input logic j,    // J input for JK flip-flop
    input logic k,    // K input for JK flip-flop
    output logic Q    // Flip-flop output
);

    initial begin
        Q = 1'b0;  // Initial state
    end

    always @(*) begin
        case ({j, k})
            2'b00: Q = Q;      // Maintain state
            2'b01: Q = 1'b0;   // Reset the output
            2'b10: Q = 1'b1;   // Set the output
            2'b11: Q = ~Q;     // Toggle the output
        endcase
    end

endmodule