module TopModule (
    input logic clk,      // Clock signal, positive edge-triggered
    input logic in,       // Data input, one bit
    output logic out      // Data output, one bit
);

always @(posedge clk) begin
    out <= in ^ out; // XOR operation: out = in XOR out
end

endmodule