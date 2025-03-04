module TopModule (
    input logic in,
    input logic [3:0] state,
    input logic reset_n,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        // Default next state and output
        next_state = 4'b0000;
        out = 1'b0;

        // Next state logic
        next_state[0] = (state[0] & ~in) | (state[2] & ~in);
        next_state[1] = (state[0] & in) | (state[1] & in) | (state[3] & in);
        next_state[2] = (state[1] & ~in) | (state[3] & ~in);
        next_state[3] = (state[2] & in);

        // Output logic
        out = state[3];
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Asynchronous reset to state A
            state <= 4'b0001;
        end else begin
            // State transition
            state <= next_state;
        end
    end

endmodule