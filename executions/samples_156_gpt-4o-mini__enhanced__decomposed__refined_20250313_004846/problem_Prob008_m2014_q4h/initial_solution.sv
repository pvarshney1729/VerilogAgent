```verilog
[BEGIN]
module TopModule (
    input logic in,    // Single-bit input port
    output logic out   // Single-bit output port
);

// Combinational Logic Behavior:
always @(*) begin
    out = in; // Combinational assignment
end

endmodule
[DONE]
```