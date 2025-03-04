```verilog
module TopModule (
    input  wire clk,  // Clock signal
    input  wire w,    // Input from previous stage
    input  wire R,    // Value to load
    input  wire E,    // Enable shift
    input  wire L,    // Load signal
    output reg  Q     // Output to next stage
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= w;
        end
    end

endmodule
```