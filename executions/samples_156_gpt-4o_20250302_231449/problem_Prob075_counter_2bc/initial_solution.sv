module TopModule (
    input logic clk,        // Clock signal, active on positive edge
    input logic areset,     // Asynchronous reset, active on positive edge
    input logic train_valid,// Training validity signal
    input logic train_taken,// Training taken signal
    output logic [1:0] state // 2-bit output representing the counter state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset state to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) begin
                    state <= state + 1; // Increment state
                end
            end else begin
                if (state != 2'b00) begin
                    state <= state - 1; // Decrement state
                end
            end
        end
    end

endmodule