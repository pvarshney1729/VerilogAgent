```verilog
module DFlipFlop (
    input logic clk,    // Clock signal, positive-edge triggered
    input logic d,      // Data input
    input logic r,      // Active high synchronous reset
    output logic q      // Data output
);

    always_ff @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
```