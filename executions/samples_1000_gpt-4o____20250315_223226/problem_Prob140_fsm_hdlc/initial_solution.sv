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

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in) next_state = ONE;
            end
            ONE: begin
                if (in) next_state = TWO_ONES;
                else next_state = IDLE;
            end
            TWO_ONES: begin
                if (in) next_state = THREE_ONES;
                else next_state = IDLE;
            end
            THREE_ONES: begin
                if (in) next_state = FOUR_ONES;
                else next_state = IDLE;
            end
            FOUR_ONES: begin
                if (in) next_state = FIVE_ONES;
                else next_state = IDLE;
            end
            FIVE_ONES: begin
                if (in) next_state = SIX_ONES;
                else begin
                    next_state = IDLE;
                    disc = 1'b1; // 0111110 detected
                end
            end
            SIX_ONES: begin
                if (in) next_state = SEVEN_ONES;
                else begin
                    next_state = IDLE;
                    flag = 1'b1; // 01111110 detected
                end
            end
            SEVEN_ONES: begin
                if (in) begin
                    next_state = SEVEN_ONES;
                    err = 1'b1; // 01111111... detected
                end else begin
                    next_state = IDLE;
                    err = 1'b1; // 01111111 detected
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule