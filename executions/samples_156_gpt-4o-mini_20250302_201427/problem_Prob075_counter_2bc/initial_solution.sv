module TopModule (
    input logic clk,               // Clock signal
    input logic areset,            // Asynchronous reset, active high
    input logic train_valid,       // Training validity signal
    input logic train_taken,       // Taken signal
    output logic [1:0] state       // 2-bit unsigned counter output
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;         // Asynchronous reset to weakly not-taken state
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 1; // Increment state
                end
            end else begin
                if (state > 2'b00) begin
                    state <= state - 1; // Decrement state
                end
            end
        end
    end

endmodule