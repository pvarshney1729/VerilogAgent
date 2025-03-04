```verilog
module TopModule(
    input logic a,  // 1-bit input signal
    input logic b,  // 1-bit input signal
    input logic c,  // 1-bit input signal
    input logic d,  // 1-bit input signal
    output logic out // 1-bit output signal
);

    // Combinational logic derived from Karnaugh map
    assign out = (!a & !b & c & !d) | (!a & b & !c & d) | (a & !b & c & !d) | (a & b & !c & d);

endmodule
```