```verilog
module TopModule (
    input logic d,      // Data input to the D latch
    input logic ena,    // Enable signal, active high
    output logic q      // Output of the D latch
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        // else q retains its previous state
    end

endmodule
```