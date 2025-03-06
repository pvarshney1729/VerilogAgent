module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

always @(*) begin
    out = in ^ out; // Combinational logic: XOR operation
end

always @(posedge clk) begin
    out <= in ^ out; // Sequential logic: D flip-flop capturing XOR output
end

endmodule