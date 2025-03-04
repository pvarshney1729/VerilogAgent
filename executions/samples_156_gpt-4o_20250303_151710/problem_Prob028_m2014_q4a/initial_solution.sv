```verilog
module TopModule (
    input logic d,
    input logic ena,
    output logic q
);
    // Combinational logic implementing a D latch
    always @(*) begin
        if (ena) begin
            q = d; // Transparent phase
        end
        // Opaque phase: q retains its value
    end
endmodule
```