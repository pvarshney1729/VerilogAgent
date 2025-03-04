```verilog
module TopModule(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    logic p_next;
    logic q_next;

    // Initial state
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic for p
    always_ff @(posedge clock) begin
        if (a == 1'b1) begin
            p <= 1'b1;
        end
    end

    // Sequential logic for q
    always_ff @(negedge clock) begin
        if (p == 1'b1) begin
            q <= p;
        end
    end

endmodule
```