[BEGIN]
```verilog
module TopModule (
    input  logic in1,  // Single-bit input
    input  logic in2,  // Single-bit input
    input  logic in3,  // Single-bit input
    output logic out   // Single-bit output
);

    logic xnor_out;  // Intermediate logic for XNOR output

    always @(*) begin
        xnor_out = ~(in1 ^ in2);  // XNOR operation
        out = xnor_out ^ in3;     // XOR operation with xnor_out and in3
    end

endmodule
```
[DONE]