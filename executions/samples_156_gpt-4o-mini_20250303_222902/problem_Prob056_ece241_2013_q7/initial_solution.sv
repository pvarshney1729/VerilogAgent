module TopModule (
    input logic clk, // Clock signal, positive edge-triggered
    input logic j,   // J input of the JK flip-flop
    input logic k,   // K input of the JK flip-flop
    output logic Q   // Q output of the JK flip-flop
);

always @(posedge clk) begin
    case ({j, k})
        2'b00: Q <= Q;    // No change
        2'b01: Q <= 1'b0; // Reset
        2'b10: Q <= 1'b1; // Set
        2'b11: Q <= ~Q;   // Toggle
    endcase
end

endmodule