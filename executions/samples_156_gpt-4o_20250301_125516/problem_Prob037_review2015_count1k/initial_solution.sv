```verilog
module TopModule (
    input logic clk,        // 1-bit clock signal
    input logic reset,      // 1-bit active high synchronous reset signal
    output logic [9:0] q    // 10-bit wide counter output
);

    // Internal register to hold the counter value
    logic [9:0] counter;

    // Sequential logic for counter operation
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'd0; // Reset counter to 0
        end else if (counter == 10'd999) begin
            counter <= 10'd0; // Wrap around to 0 after reaching 999
        end else begin
            counter <= counter + 10'd1; // Increment counter
        end
    end

    // Assign the internal counter value to the output
    assign q = counter;

endmodule
```