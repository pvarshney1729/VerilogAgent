```verilog
[BEGIN]
module TopModule (
    input logic in,    // 1-bit input signal
    output logic out   // 1-bit output signal
);

    always @(*) begin
        out = in; // Direct assignment to mimic wire behavior
    end

endmodule
[DONE]
```