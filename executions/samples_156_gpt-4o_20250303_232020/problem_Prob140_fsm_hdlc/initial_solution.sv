module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        ZERO,
        ONE,
        TWO,
        THREE,
        FOUR,
        FIVE,
        SIX,
        DISC,
        FLAG,
        ERR
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ZERO;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        case (current_state)
            ZERO: begin
                if (in) next_state = ONE;
            end
            ONE: begin
                if (in) next_state = TWO;
                else next_state = ZERO;
            end
            TWO: begin
                if (in) next_state = THREE;
                else next_state = ZERO;
            end
            THREE: begin
                if (in) next_state = FOUR;
                else next_state = ZERO;
            end
            FOUR: begin
                if (in) next_state = FIVE;
                else next_state = ZERO;
            end
            FIVE: begin
                if (in) next_state = SIX;
                else next_state = ZERO;
            end
            SIX: begin
                if (in) next_state = ERR;
                else next_state = DISC;
            end
            DISC: begin
                disc = 1'b1;
                next_state = ZERO;
            end
            FLAG: begin
                flag = 1'b1;
                next_state = ZERO;
            end
            ERR: begin
                err = 1'b1;
                next_state = ZERO;
            end
            default: next_state = ZERO;
        endcase
    end

    // Output logic for FLAG state
    always_comb begin
        if (current_state == SIX && in == 1'b0) begin
            next_state = FLAG;
        end
    end

endmodule