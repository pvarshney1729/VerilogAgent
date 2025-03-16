module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        ONE_1     = 3'b001,
        TWO_1     = 3'b010,
        THREE_1   = 3'b011,
        FOUR_1    = 3'b100,
        FIVE_1    = 3'b101,
        SIX_1     = 3'b110,
        SEVEN_1   = 3'b111
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

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in) next_state = ONE_1;
                else next_state = IDLE;
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
                else begin
                    next_state = IDLE;
                    disc = 1'b1; // 0111110 detected
                end
            end
            SIX_1: begin
                if (in) next_state = SEVEN_1;
                else begin
                    next_state = IDLE;
                    flag = 1'b1; // 01111110 detected
                end
            end
            SEVEN_1: begin
                if (in) begin
                    next_state = SEVEN_1;
                    err = 1'b1; // 01111111... detected
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule