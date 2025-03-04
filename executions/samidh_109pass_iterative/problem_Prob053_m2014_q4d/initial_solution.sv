module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

// Initial state declaration
initial begin
    out = 1'b0; // Initialize output to a known state
end

always @(posedge clk) begin
    out <= in ^ out; // XOR logic and D flip-flop functionality
end

endmodule