[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        ONE_1       = 3'b001,
        TWO_1       = 3'b010,
        THREE_1     = 3'b011,
        FOUR_1      = 3'b100,
        FIVE_1      = 3'b101,
        SIX_1       = 3'b110,
        ERROR       = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in) next_state = ONE_1;
            end
            ONE_1: begin
                if (in) next_state = TWO_1;
                else next_state = IDLE;
            end
            TWO_1: begin
                if (in) next_state = THREE_1;
                else next_state = IDLE;
            end
            THREE_1: begin
                if (in) next_state = FOUR_1;
                else next_state = IDLE;
            end
            FOUR_1: begin
                if (in) next_state = FIVE_1;
                else next_state = IDLE;
            end
            FIVE_1: begin
                if (in) next_state = SIX_1;
                else next_state = IDLE;
            end
            SIX_1: begin
                if (in) next_state = ERROR;
                else next_state = IDLE;
            end
            ERROR: begin
                if (in) next_state = ERROR;
                else next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        case (current_state)
            FIVE_1: begin
                if (!in) disc = 1'b1;
            end
            SIX_1: begin
                if (!in) flag = 1'b1;
            end
            ERROR: begin
                err = 1'b1;
            end
        endcase
    end

endmodule
[END]