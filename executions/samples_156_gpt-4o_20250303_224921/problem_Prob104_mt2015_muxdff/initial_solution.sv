```verilog
module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic L,            // Load signal; when high, loads input to output
    input logic q_in,         // Input from the previous flip-flop or external source
    input logic r_in,         // Input that can be loaded directly into the flip-flop
    output logic Q            // Output of the flip-flop; 1-bit wide
);

    // Synchronous logic with synchronous reset
    always_ff @(posedge clk) begin
        if (L) begin
            Q <= r_in;        // Load r_in into Q when L is high
        end else begin
            Q <= q_in;        // Load q_in into Q when L is low
        end
    end

endmodule
```