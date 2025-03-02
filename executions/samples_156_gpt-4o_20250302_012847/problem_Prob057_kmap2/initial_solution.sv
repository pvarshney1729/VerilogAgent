```verilog
module TopModule(
    input logic a,  // 1-bit, unsigned
    input logic b,  // 1-bit, unsigned
    input logic c,  // 1-bit, unsigned
    input logic d,  // 1-bit, unsigned
    output logic out // 1-bit, unsigned
);

    assign out = (!c & !d & (a | !b)) | 
                 (!c & d & (!a | b)) | 
                 (c & d & (b | !a)) | 
                 (c & !d & a & b);

endmodule
```