module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        ONE        = 3'b001,
        TWO_ONES   = 3'b010,
        THREE_ONES = 3'b011,
        FOUR_ONES  = 3'b100,
        FIVE_ONES  = 3'b101,
        SIX_ONES   = 3'b110,
        SEVEN_ONES = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State register with synchronous reset
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
                if (in) 
                    next_state = ONE;
                else 
                    next_state = IDLE;
            end
            ONE: begin
                if (in) 
                    next_state = TWO_ONES;
                else 
                    next_state = IDLE;
            end
            TWO_ONES: begin
                if (in) 
                    next_state = THREE_ONES;
                else 
                    next_state = IDLE;
            end
            THREE_ONES: begin
                if (in) 
                    next_state = FOUR_ONES;
                else 
                    next_state = IDLE;
            end
            FOUR_ONES: begin
                if (in) 
                    next_state = FIVE_ONES;
                else 
                    next_state = IDLE;
            end
            FIVE_ONES: begin
                if (in) 
                    next_state = SIX_ONES;
                else 
                    next_state = IDLE;
            end
            SIX_ONES: begin
                if (in) 
                    next_state = SEVEN_ONES;
                else 
                    next_state = IDLE;
            end
            SEVEN_ONES: begin
                if (in) 
                    next_state = SEVEN_ONES; // Remain in error state
                else 
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        // Default assignments
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;

        case (current_state)
            FIVE_ONES: begin
                if (!in) disc = 1'b1; // 0111110 pattern
            end
            SIX_ONES: begin
                if (!in) flag = 1'b1; // 01111110 pattern
            end
            SEVEN_ONES: begin
                err = 1'b1; // 01111111... pattern
            end
            default: begin
                // No output asserted
            end
        endcase
    end

endmodule