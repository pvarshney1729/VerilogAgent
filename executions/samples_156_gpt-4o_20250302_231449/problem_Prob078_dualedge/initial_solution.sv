```verilog
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic q_pos, q_neg;

    // Capture data on the rising edge
    always_ff @(posedge clk) begin
        q_pos <= d;
    end

    // Capture data on the falling edge
    always_ff @(negedge clk) begin
        q_neg <= d;
    end

    // Combine the results to mimic dual-edge triggering
    always_comb begin
        q = clk ? q_pos : q_neg;
    end

endmodule
```