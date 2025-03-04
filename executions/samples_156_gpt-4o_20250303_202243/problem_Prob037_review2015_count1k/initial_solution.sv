module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    // Internal register to hold the counter value
    logic [9:0] counter;

    // Sequential logic for counter and synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0; // Reset counter to 0
        end else if (counter == 10'd999) begin
            counter <= 10'b0; // Roll over to 0 when counter reaches 999
        end else begin
            counter <= counter + 10'b1; // Increment counter
        end
    end

    // Assign the internal counter value to the output
    assign q = counter;

endmodule