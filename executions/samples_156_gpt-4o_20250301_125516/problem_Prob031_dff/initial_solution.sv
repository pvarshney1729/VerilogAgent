```verilog
module TopModule (
    input logic clk,      // Clock input, positive-edge triggered
    input logic d,        // Data input for the D flip-flop
    output logic q        // Output of the D flip-flop
);

    always_ff @(posedge clk) begin
        q <= d; // On the positive edge of clk, capture the value of d into q
    end

endmodule
```