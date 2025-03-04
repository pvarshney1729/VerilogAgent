module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Active high, synchronous reset
    input logic in,           // Serial data input
    output logic disc,        // Discard signal
    output logic flag,        // Frame boundary flag
    output logic err          // Error signal
);

    typedef enum logic [2:0] {
        IDLE,
        ONE_1,
        TWO_1s,
        THREE_1s,
        FOUR_1s,
        FIVE_1s,
        FIVE_1s_ZERO,
        FLAG,
        ERROR
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (next_state)
                FIVE_1s_ZERO: disc <= 1;
                FLAG: flag <= 1;
                ERROR: err <= 1;
            endcase
        end
    end

    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in) next_state = ONE_1;
            end
            ONE_1: begin
                if (in) next_state = TWO_1s; else next_state = IDLE;
            end
            TWO_1s: begin
                if (in) next_state = THREE_1s; else next_state = IDLE;
            end
            THREE_1s: begin
                if (in) next_state = FOUR_1s; else next_state = IDLE;
            end
            FOUR_1s: begin
                if (in) next_state = FIVE_1s; else next_state = IDLE;
            end
            FIVE_1s: begin
                if (in) next_state = ERROR; else next_state = FIVE_1s_ZERO;
            end
            FIVE_1s_ZERO: begin
                if (in) next_state = FLAG; else next_state = IDLE;
            end
            FLAG: begin
                if (!in) next_state = IDLE; // Return to IDLE after FLAG
            end
            ERROR: begin
                if (!in) next_state = IDLE; // Return to IDLE after ERROR
            end
        endcase
    end

endmodule