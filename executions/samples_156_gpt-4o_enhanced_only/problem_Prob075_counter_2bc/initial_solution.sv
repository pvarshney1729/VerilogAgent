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
            // On asynchronous reset, set counter to 2'b01
            counter <= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    // Increment counter if not saturated at 2'b11
                    if (counter < 2'b11) begin
                        counter <= counter + 1;
                    end
                end else begin
                    // Decrement counter if not saturated at 2'b00
                    if (counter > 2'b00) begin
                        counter <= counter - 1;
                    end
                end
            end
            // If train_valid is 0, counter remains unchanged
        end
    end
    
    // Assign the counter to the output state
    assign state = counter;

endmodule