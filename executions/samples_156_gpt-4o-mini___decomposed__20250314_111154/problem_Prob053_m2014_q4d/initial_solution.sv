module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

logic xor_out;

assign xor_out = in ^ out;

always @(posedge clk) begin
    out <= xor_out;
end

endmodule