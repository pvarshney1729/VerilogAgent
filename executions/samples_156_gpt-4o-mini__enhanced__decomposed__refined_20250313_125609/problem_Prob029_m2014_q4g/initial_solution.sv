[BEGIN]
```verilog
module TopModule (
    input logic in1,    // One-bit input
    input logic in2,    // One-bit input
    input logic in3,    // One-bit input
    output logic out    // One-bit output
);
    logic xnor_out; // Intermediate logic for XNOR output

    always @(*) begin
        xnor_out = ~(in1 ^ in2); // XNOR operation
        out = xnor_out ^ in3;    // XOR operation
    end
endmodule
```
[DONE]