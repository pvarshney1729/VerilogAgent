module TopModule (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic async_reset,    // Asynchronous reset, active high
    input logic train_valid,    // Indicates if training data is valid
    input logic train_taken,    // Indicates if training is taken
    output logic [1:0] state    // 2-bit counter state output
);

    // Asynchronous reset
    always_ff @(posedge async_reset) begin
        state <= 2'b01; // Reset state
    end

    // Synchronous logic
    always_ff @(posedge clk) begin
        if (train_valid) begin
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

    // Initial state
    initial begin
        state = 2'b01; // Set initial state
    end

endmodule