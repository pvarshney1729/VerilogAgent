```verilog
[BEGIN]
module TopModule (
    input logic clock,  // Clock signal, used for the sequential logic
    input logic a,      // 1-bit input signal
    output logic p,     // 1-bit output signal
    output logic q      // 1-bit output signal
);

    always_ff @(posedge clock) begin
        if (a) begin
            p <= 1'b1;
        end else begin
            p <= 1'b0;
        end
        q <= p;
    end

    initial begin
        p = 1'b0;
        q = 1'b0;
    end

endmodule
[DONE]
```