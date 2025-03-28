module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 1; // Increment counter
                end
            end else begin
                if (state > 2'b00) begin
                    state <= state - 1; // Decrement counter
                end
            end
        end
        // If train_valid is 0, state remains unchanged
    end

endmodule