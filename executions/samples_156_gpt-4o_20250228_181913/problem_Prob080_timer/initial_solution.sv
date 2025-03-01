module TopModule (
    input logic clk,          // Clock signal, triggers on the positive edge
    input logic rst,          // Synchronous reset, active high
    input logic load,         // Load signal, active high
    input logic [9:0] data,   // 10-bit data input, bit[0] is the least significant bit
    output logic tc           // Terminal count output, active high when counter reaches 0
);

    logic [9:0] counter;      // Internal 10-bit down-counter

    always @(posedge clk) begin
        if (rst) begin
            counter <= 10'b0; // Initialize counter to 0 on reset
            tc <= 1'b0;       // Deassert terminal count on reset
        end else if (load) begin
            counter <= data;   // Load the counter
            tc <= (data == 10'b0); // Set tc based on loaded data
        end else if (counter != 10'b0) begin
            counter <= counter - 1; // Decrement counter
            tc <= (counter == 10'b1); // Assert tc when counter reaches 0
        end
    end

endmodule