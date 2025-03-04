module TopModule (
    input logic clk,       // Clock signal
    input logic reset,     // Synchronous, active-high reset signal
    output logic [3:0] q   // 4-bit counter output
);

    // Internal register to hold the counter value
    logic [3:0] counter;

    // Sequential logic for counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 4'b0000; // Reset counter to 0
        end else begin
            if (counter == 4'b1111) begin
                counter <= 4'b0000; // Wrap around to 0
            end else begin
                counter <= counter + 1; // Increment counter
            end
        end
    end

    // Assign internal counter to output
    assign q = counter;

endmodule