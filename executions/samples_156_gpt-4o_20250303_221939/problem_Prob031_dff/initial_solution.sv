```verilog
module TopModule (
    input logic clk,         // Clock input, triggers on the positive edge
    input logic data_in,     // Data input to the D flip-flop
    output logic data_out,   // Data output from the D flip-flop
    input logic rst_n        // Active-low asynchronous reset
);

// Sequential logic with asynchronous reset.
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 1'b0; // Reset state
    end else begin
        data_out <= data_in; // Capture input on rising edge of clk
    end
end

endmodule
```