module TopModule(
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    // Internal register to hold the counter value
    logic [1:0] counter;

    // Asynchronous reset and counter update logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11) begin
                    counter <= counter + 1; // Increment counter
                end
            end else begin
                if (counter > 2'b00) begin
                    counter <= counter - 1; // Decrement counter
                end
            end
        end
    end

    // Assign the counter value to the output state
    assign state = counter;

endmodule