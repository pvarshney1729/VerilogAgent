```verilog
module TopModule (
    input logic clock,  // Clock signal, assumed to be single-bit
    input logic a,      // Single-bit input signal
    output logic p,     // Single-bit output signal
    output logic q      // Single-bit output signal
);

    always_ff @(posedge clock) begin
        if (a)
            p <= 1'b1;
        else
            p <= 1'b0;
        q <= p;
    end

endmodule
```