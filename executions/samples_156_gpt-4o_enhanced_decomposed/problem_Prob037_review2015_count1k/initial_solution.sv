module TopModule(
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    // Internal 10-bit counter
    logic [9:0] counter;

    // Sequential logic for counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'd0; // Reset counter to 0
        end else if (counter == 10'd999) begin
            counter <= 10'd0; // Wrap around to 0 after reaching 999
        end else begin
            counter <= counter + 10'd1; // Increment counter
        end
    end

    // Assign counter value to output
    assign q = counter;

endmodule