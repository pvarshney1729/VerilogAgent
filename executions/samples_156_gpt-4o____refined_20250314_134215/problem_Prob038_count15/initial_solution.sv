[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [3:0] q
);

    // Internal register to hold the counter value
    logic [3:0] counter;

    // Sequential logic for the counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 4'b0000; // Reset counter to 0
        end else begin
            counter <= counter + 4'b0001; // Increment counter
        end
    end

    // Assign the counter value to the output
    assign q = counter;

endmodule
[DONE]