```
[BEGIN]
module TopModule (
    input logic clk,                // Clock signal (1 bit)
    input logic reset,              // Synchronous reset signal (1 bit)
    input logic shift_ena,         // Shift enable control signal (1 bit)
    input logic count_ena,         // Count enable control signal (1 bit)
    input logic data,              // Data input for shifting (1 bit)
    output logic [3:0] q           // 4-bit output shift register and down counter
);

    // Synchronous reset behavior and operation logic
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Initialize q to 4'b0000 on reset
        end else if (shift_ena) begin
            q <= {data, q[3:1]}; // Shift data into q[3]
        end else if (count_ena) begin
            q <= (q > 4'b0000) ? (q - 4'b0001) : 4'b0000; // Decrement the counter, prevent underflow
        end
    end

endmodule
[DONE]
```