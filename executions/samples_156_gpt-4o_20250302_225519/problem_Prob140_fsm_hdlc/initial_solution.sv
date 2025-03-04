module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        IDLE,
        ONE,
        TWO,
        THREE,
        FOUR,
        FIVE,
        SIX,
        SEVEN,
        ERROR
    } state_t;

    state_t current_state, next_state;
    logic [6:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 7'b0;
        end else begin
            current_state <= next_state;
            shift_reg <= {shift_reg[5:0], in};
        end
    end

    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in) next_state = ONE;
            end
            ONE: begin
                if (in) next_state = TWO;
                else next_state = IDLE;
            end
            TWO: begin
                if (in) next_state = THREE;
                else next_state = IDLE;
            end
            THREE: begin
                if (in) next_state = FOUR;
                else next_state = IDLE;
            end
            FOUR: begin
                if (in) next_state = FIVE;
                else next_state = IDLE;
            end
            FIVE: begin
                if (in) next_state = SIX;
                else next_state = IDLE;
            end
            SIX: begin
                if (in) next_state = SEVEN;
                else begin
                    next_state = IDLE;
                    disc = 1'b1;
                end
            end
            SEVEN: begin
                if (in) begin
                    next_state = ERROR;
                    err = 1'b1;
                end else begin
                    next_state = IDLE;
                    flag = 1'b1;
                end
            end
            ERROR: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule