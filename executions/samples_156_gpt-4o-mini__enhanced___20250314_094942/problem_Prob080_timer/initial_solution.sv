```verilog
module TopModule (
    input logic clk,              // Clock input (1 bit)
    input logic load,             // Load signal (1 bit)
    input logic [9:0] data,       // Input data for counter load (10 bits, unsigned)
    output logic tc               // Terminal count output signal (1 bit)
);

// Internal signal to hold the counter value
logic [9:0] counter;              // Internal counter (10 bits, unsigned)

// Initialization of the counter and output
initial begin
    counter = 10'b0;            // Initialize counter to 0
    tc = 1'b0;                  // Initialize terminal count to 0
end

// Always block for counter behavior
always @(posedge clk) begin
    if (load) begin
        counter <= data;         // Load the counter with `data` on load signal
        tc <= 1'b0;             // Reset terminal count when loading new value
    end else begin
        if (counter > 0) begin
            counter <= counter - 1; // Decrement counter
        end
        tc <= (counter == 10'b0);   // Assert terminal count when counter reaches 0
    end
end

endmodule
```