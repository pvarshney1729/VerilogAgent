module TopModule (
    input logic clk,    // Clock signal
    input logic in,     // Data input
    output logic out    // Output of the D flip-flop
);

// Initialize the output on startup
initial begin
    out = 1'b0;
end

// Sequential logic: D flip-flop with XOR feedback
always_ff @(posedge clk) begin
    out <= in ^ out;
end

endmodule