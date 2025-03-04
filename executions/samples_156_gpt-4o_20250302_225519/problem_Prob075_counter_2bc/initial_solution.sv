module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    // Initial state
    initial begin
        state = 2'b01;
    end

    // Sequential logic for state update
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to weakly not-taken state
        end else if (train_valid) begin
            if (train_taken) begin
                if (state != 2'b11) begin
                    state <= state + 1;
                end
            end else begin
                if (state != 2'b00) begin
                    state <= state - 1;
                end
            end
        end
    end

endmodule