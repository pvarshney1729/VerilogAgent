```verilog
module TopModule (
    input logic clk,        // Clock signal
    input logic L,          // Load control signal
    input logic q_in,       // Input from multiplexer
    input logic r_in,       // Input for loading
    output logic Q          // Flip-flop output
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
```