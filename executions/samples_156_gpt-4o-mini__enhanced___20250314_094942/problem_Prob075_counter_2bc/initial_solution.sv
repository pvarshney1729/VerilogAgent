module TopModule (
    input logic clk,                // Clock signal (1-bit)
    input logic areset,            // Asynchronous active-high reset (1-bit)
    input logic train_valid,       // Indicates if the training is valid (1-bit)
    input logic train_taken,       // Indicates if training was taken (1-bit)
    output logic [1:0] state       // Two-bit saturating counter output
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 1; // Increment
                end
            end else begin
                if (state > 2'b00) begin
                    state <= state - 1; // Decrement
                end
            end
        end
    end

endmodule