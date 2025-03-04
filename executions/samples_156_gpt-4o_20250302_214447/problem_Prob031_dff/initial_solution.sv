```verilog
module TopModule (
    input logic clk,        // Clock signal, positive-edge triggered
    input logic d,          // Data input for the D flip-flop
    output logic q          // Output of the D flip-flop
);

    always_ff @(posedge clk) begin
        q <= d;  // On the positive edge of clk, assign the value of d to q
    end

endmodule
```