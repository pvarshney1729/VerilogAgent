```verilog
module TopModule (
    input  wire clk,  // Clock signal, triggers on rising edge
    input  wire ar,   // Asynchronous reset signal, active high
    input  wire d,    // Data input for the D flip-flop
    output reg  q     // Data output of the D flip-flop
);

    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
```