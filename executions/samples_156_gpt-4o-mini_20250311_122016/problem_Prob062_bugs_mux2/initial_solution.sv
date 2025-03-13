```verilog
[BEGIN]
module Mux8Bit2to1 (
    input        sel,    // Selection signal
    input  [7:0] a,      // 8-bit input vector a
    input  [7:0] b,      // 8-bit input vector b
    output logic [7:0] y // 8-bit output vector y
);

    // Multiplexer logic using always block for combinational selection
    always @(*) begin
        y = sel ? b : a; // Conditional selection based on sel
    end

endmodule
[DONE]
```