module TopModule (
    input logic clk,            // Clock input signal
    input logic d_input,       // Data input for the D flip-flop
    output logic q_output       // Output of the D flip-flop
);

// Initial state of the flip-flop
initial begin
    q_output = 1'b0;          // Set initial state of the flip-flop
end

// Sequential logic for D flip-flop
always @(posedge clk) begin
    q_output <= d_input;      // On clock edge, output takes the value of d_input
end

endmodule