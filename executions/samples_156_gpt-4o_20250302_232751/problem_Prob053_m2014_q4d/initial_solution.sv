module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

logic d;

always_comb begin
    // XOR operation
    d = in ^ out;
end

always_ff @(posedge clk) begin
    // State capture
    out <= d;
end

endmodule