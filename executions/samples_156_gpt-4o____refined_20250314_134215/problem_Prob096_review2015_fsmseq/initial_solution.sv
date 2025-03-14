[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        S1      = 3'b001,
        S11     = 3'b010,
        S110    = 3'b011,
        S1101   = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state; // Default state transition
        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (!data)
                    next_state = S110;
                else
                    next_state = S11; // Stay in S11 if data is 1
            end
            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end
            S1101: begin
                next_state = S1101; // Remain in this state once sequence is detected
            end
            default: next_state = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (current_state == S1101)
            start_shifting <= 1'b1;
    end

endmodule
[DONE]