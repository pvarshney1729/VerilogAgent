```verilog
module TopModule (
    input logic in_bit,
    output logic out_bit
);
    // Direct wire connection
    assign out_bit = in_bit;
endmodule
```