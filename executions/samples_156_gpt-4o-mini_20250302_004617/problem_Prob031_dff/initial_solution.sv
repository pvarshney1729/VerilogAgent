```verilog
module TopModule (
    input  logic clk,       // Clock signal
    input  logic d,         // Data input
    input  logic reset_n,   // Asynchronous active-low reset
    output logic q          // Flip-flop output
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 1'b0;     // Reset state
        else
            q <= d;        // Capture input on rising edge of clk
    end
endmodule
```