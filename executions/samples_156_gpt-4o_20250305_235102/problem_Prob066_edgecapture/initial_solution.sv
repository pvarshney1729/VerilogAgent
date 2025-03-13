```verilog
[BEGIN]
module TopModule (
    input logic clk,                     // Clock signal, positive edge triggered
    input logic reset,                   // Active high synchronous reset
    input logic [31:0] in,               // 32-bit input vector
    output logic [31:0] out              // 32-bit output vector
);

    logic [31:0] prev_in;                // Register to hold the previous state of the input

    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;                // Clear output on reset
            prev_in <= 32'b0;            // Clear previous input on reset
        end else begin
            out <= out | (prev_in & ~in); // Set out[i] if transition from 1 to 0 is detected
            prev_in <= in;               // Update previous input state
        end
    end

endmodule
[DONE]
```