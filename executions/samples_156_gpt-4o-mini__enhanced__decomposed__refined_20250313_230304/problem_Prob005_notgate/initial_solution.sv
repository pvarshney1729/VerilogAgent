```verilog
module TopModule (
    input logic in,       
    output logic out      
);

assign out = ~in; // Logical NOT operation on the input signal

endmodule
```