module fsm (
    input logic clk,
    input logic reset,
    input logic ground_status,
    input logic bump,
    input logic dig,
    output logic digging,
    output logic moving
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        GROUND = 2'b01,
        BUMP = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (ground_status) begin
                    next_state = GROUND;
                end else if (bump) begin
                    next_state = BUMP;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = IDLE;
                end
            end
            GROUND: begin
                if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = GROUND;
                end
            end
            BUMP: begin
                if (ground_status) begin
                    next_state = GROUND;
                end else begin
                    next_state = BUMP;
                end
            end
            DIGGING: begin
                if (!dig) begin
                    next_state = IDLE;
                end else begin
                    next_state = DIGGING;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        digging = (current_state == DIGGING);
        moving = (current_state == GROUND || current_state == BUMP);
    end

endmodule