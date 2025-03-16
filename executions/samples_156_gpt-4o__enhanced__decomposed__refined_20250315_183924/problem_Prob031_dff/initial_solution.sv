```verilog
module TopModule (
    input logic clk,  // Clock signal
    input logic d,    // Data input
    output logic q    // Output
);

    initial begin
        q = 1'b0; // Initialize q to 0
    end

    always_ff @(posedge clk) begin
        q <= d; // Capture the value of d on the rising edge of clk
    end

endmodule
```