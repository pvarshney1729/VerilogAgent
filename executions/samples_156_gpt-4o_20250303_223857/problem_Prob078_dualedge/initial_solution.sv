```verilog
module TopModule (
    input wire clk,        // Clock input
    input wire reset_n,    // Active low asynchronous reset
    input wire d,          // Data input
    output reg q           // Output data
);

    // Internal signal to hold the data between clock edges
    reg d_internal;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 1'b0;
        else
            d_internal <= d;  // Capture data on the rising edge
    end

    always @(negedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 1'b0;
        else
            q <= d_internal;  // Output data on the falling edge
    end

endmodule
```