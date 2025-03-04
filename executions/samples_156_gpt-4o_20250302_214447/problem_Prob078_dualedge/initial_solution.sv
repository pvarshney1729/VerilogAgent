```verilog
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    // Intermediate register for dual-edge emulation
    logic d_rising;

    always_ff @(posedge clk) begin
        d_rising <= d;
    end

    always_ff @(negedge clk) begin
        q <= d_rising;
    end

endmodule
```