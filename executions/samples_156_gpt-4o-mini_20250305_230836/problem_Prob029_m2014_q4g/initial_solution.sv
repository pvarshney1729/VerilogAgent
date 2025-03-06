```verilog
[BEGIN]
module TopModule (
    input logic in1,  // Single-bit input, active high
    input logic in2,  // Single-bit input, active high
    input logic in3,  // Single-bit input, active high
    output logic out  // Single-bit output, active high
);

always @(*) begin
    out = ~(in1 ^ in2) ^ in3;  // XNOR followed by XOR operation
end

endmodule
[DONE]
```