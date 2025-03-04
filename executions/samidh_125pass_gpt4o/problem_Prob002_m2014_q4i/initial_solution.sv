```verilog
module TopModule (
    output logic out_signal // 1-bit output, always logic low
);
    // Combinational logic to drive output low
    assign out_signal = 1'b0;
endmodule
```