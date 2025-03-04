```verilog
module TopModule(
    input logic x,  // 1-bit input signal
    input logic y,  // 1-bit input signal
    output logic z  // 1-bit output signal
);

    always @(*) begin
        z = (~x & ~y) | (x & y);
    end

endmodule
```