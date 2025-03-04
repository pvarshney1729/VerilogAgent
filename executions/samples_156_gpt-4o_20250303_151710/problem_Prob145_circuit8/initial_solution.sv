```verilog
module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Initial state
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic
    always_ff @(posedge clock) begin
        if (a == 1'b1 && p == 1'b0) begin
            p <= 1'b1;
            q <= 1'b1;
        end else if (a == 1'b0 && p == 1'b1) begin
            p <= 1'b0;
            q <= 1'b0;
        end else begin
            q <= p;
        end
    end

endmodule
```