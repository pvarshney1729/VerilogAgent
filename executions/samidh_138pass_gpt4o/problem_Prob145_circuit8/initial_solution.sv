```verilog
[BEGIN]
module TopModule(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Initialize outputs
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic for p and q
    always_ff @(posedge clock) begin
        if (a == 1'b1) begin
            p <= 1'b1;
        end else begin
            p <= 1'b0;
        end
        q <= p;
    end

endmodule
[DONE]
```