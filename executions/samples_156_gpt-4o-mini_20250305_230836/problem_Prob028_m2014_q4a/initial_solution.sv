```verilog
[BEGIN]
module TopModule (
    input logic d,
    input logic ena,
    output logic q
);

// Level-sensitive D latch with synchronous behavior
always @(*) begin
    if (ena)
        q <= d;
    // else retain q's previous state (implied)
end

endmodule
[DONE]
```