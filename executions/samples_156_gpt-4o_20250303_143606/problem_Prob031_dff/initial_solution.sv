```verilog
module TopModule (
    input logic clk,       // Clock signal, active on the positive edge
    input logic d,         // Data input for the D flip-flop
    output logic q         // Output of the D flip-flop
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
```