```verilog
module TopModule(
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);
    logic xnor_result;

    // XNOR operation
    assign xnor_result = ~(in1 ^ in2);

    // XOR operation
    assign out = xnor_result ^ in3;

endmodule
```