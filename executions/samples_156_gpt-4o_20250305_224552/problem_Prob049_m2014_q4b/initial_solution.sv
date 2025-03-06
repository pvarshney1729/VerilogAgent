```verilog
module TopModule (
    input wire clk,   // Clock signal
    input wire ar,    // Asynchronous reset signal
    input wire d,     // Data input
    output reg q      // Flip-flop output
);

    // Initial condition for simulation
    initial begin
        q = 1'b0;
    end

    // D flip-flop with asynchronous reset
    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;  // Asynchronous reset
        end else begin
            q <= d;     // Capture data on rising edge of clock
        end
    end

endmodule
```