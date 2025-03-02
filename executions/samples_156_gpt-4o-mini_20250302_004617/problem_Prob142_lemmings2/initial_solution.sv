module lemming_behavior (
    input logic clk,
    input logic reset,
    input logic start,
    output logic move,
    output logic jump,
    output logic dig
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_MOVE = 2'b01,
        S_JUMP = 2'b10,
        S_DIG  = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S_IDLE: begin
                if (start) begin
                    next_state = S_MOVE;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_MOVE: begin
                next_state = S_JUMP; // Move leads to Jump
            end
            S_JUMP: begin
                next_state = S_DIG; // Jump leads to Dig
            end
            S_DIG: begin
                next_state = S_IDLE; // Dig leads back to Idle
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        move = 1'b0;
        jump = 1'b0;
        dig  = 1'b0;
        case (current_state)
            S_MOVE: move = 1'b1;
            S_JUMP: jump = 1'b1;
            S_DIG:  dig  = 1'b1;
        endcase
    end

endmodule