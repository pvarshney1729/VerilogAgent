[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    logic [1:0] next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Weakly not-taken state on reset
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        if (train_valid) begin
            if (train_taken) begin
                if (state < 2'b11) 
                    next_state = state + 2'b01;
                else
                    next_state = state;
            end else begin
                if (state > 2'b00) 
                    next_state = state - 2'b01;
                else
                    next_state = state;
            end
        end else begin
            next_state = state;
        end
    end

endmodule
[DONE]