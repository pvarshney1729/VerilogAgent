module TopModule (
    input  wire clk,               // Clock signal, positive-edge triggered
    input  wire areset,            // Asynchronous active-high reset
    input  wire train_valid,       // Validation signal for training
    input  wire train_taken,       // Signal to indicate training taken
    output reg  [1:0] state        // 2-bit output representing the counter state
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset state to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) begin
                    state <= state + 1;
                end
            end else begin
                if (state > 2'b00) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule