module two_bit_saturating_counter (
    input logic clk,
    input logic reset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] counter
);

    // Internal signal for the next state of the counter
    logic [1:0] next_counter;

    // Combinational logic to determine the next state of the counter
    always @(*) begin
        if (train_valid) begin
            if (train_taken) begin
                // Increment logic with saturation
                if (counter == 2'b11)
                    next_counter = 2'b11;
                else
                    next_counter = counter + 2'b01;
            end else begin
                // Decrement logic with saturation
                if (counter == 2'b00)
                    next_counter = 2'b00;
                else
                    next_counter = counter - 2'b01;
            end
        end else begin
            // If train_valid is not asserted, maintain the current state
            next_counter = counter;
        end
    end

    // Sequential logic for the counter with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 2'b01; // Reset state
        end else begin
            counter <= next_counter;
        end
    end

endmodule