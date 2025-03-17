module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        ONE     = 3'b001,
        TWO     = 3'b010,
        THREE   = 3'b011,
        FOUR    = 3'b100,
        FIVE    = 3'b101,
        SIX     = 3'b110,
        SEVEN   = 3'b111
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

    // Next state logic and output logic
    always @(*) begin
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
                else begin
                    disc = 1'b1; // 0111110 detected
                    next_state = IDLE;
                end
            end
            SIX: begin
                if (in) next_state = SEVEN;
                else begin
                    flag = 1'b1; // 01111110 detected
                    next_state = IDLE;
                end
            end
            SEVEN: begin
                if (in) begin
                    err = 1'b1; // Error: 7 or more 1s
                end else begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule