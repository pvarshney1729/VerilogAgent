module TopModule(
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    // Internal register to hold the counter value
    logic [9:0] counter;

    // Sequential logic for counter operation
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0; // Reset the counter to 0 when reset is high
        end else begin
            if (counter == 10'd999) begin
                counter <= 10'b0; // Wrap around to 0 after reaching 999
            end else begin
                counter <= counter + 1; // Increment the counter
            end
        end
    end

    // Assign the internal counter value to the output
    assign q = counter;

endmodule