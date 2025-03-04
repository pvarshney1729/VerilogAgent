module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    always @(posedge areset or posedge clk) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken
        end else begin
            if (train_valid) begin
                if (train_taken) begin
                    state <= (state < 2'b11) ? (state + 1'b1) : state; // Increment, saturate at 2'b11
                end else begin
                    state <= (state > 2'b00) ? (state - 1'b1) : state; // Decrement, saturate at 2'b00
                end
            end
        end
    end

endmodule