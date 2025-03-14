```
[BEGIN]
module TopModule (
    input logic clk,                  // Clock signal, positive edge triggered
    input logic load,                 // Load signal to load the counter
    input logic [9:0] data,           // 10-bit input data for loading the counter
    output logic tc                   // Output signal indicating terminal count (active high)
);
    logic [9:0] counter;              // Internal 10-bit counter

    always @(posedge clk) begin
        if (load) begin
            counter <= data;           // Load the counter with data
            tc <= 1'b0;                // Reset tc when loading new value
        end else if (counter > 10'b0) begin
            counter <= counter - 10'b1; // Decrement the counter
            tc <= 1'b0;                // Assert tc low while counting down
        end else begin
            tc <= 1'b1;                // Assert tc when counter reaches 0
        end
    end
endmodule
[DONE]
```