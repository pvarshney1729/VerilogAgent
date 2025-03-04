module TopModule (
    input logic clk,  // Clock signal
    input logic in,   // External input
    output logic out  // Output of the flip-flop
);

initial begin
    out = 1'b0;  // Initialize the output to a known state
end

always @(posedge clk) begin
    out <= in ^ out;  // XOR operation and D flip-flop capture
end

endmodule