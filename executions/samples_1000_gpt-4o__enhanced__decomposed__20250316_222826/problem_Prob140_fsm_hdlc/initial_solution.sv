module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        ONE_1 = 3'b001,
        TWO_1 = 3'b010,
        THREE_1 = 3'b011,
        FOUR_1 = 3'b100,
        FIVE_1 = 3'b101,
        SIX_1 = 3'b110,
        SEVEN_1 = 3'b111
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
    always_comb begin
        case (current_state)
            IDLE: next_state = in ? ONE_1 : IDLE;
            ONE_1: next_state = in ? TWO_1 : IDLE;
            TWO_1: next_state = in ? THREE_1 : IDLE;
            THREE_1: next_state = in ? FOUR_1 : IDLE;
            FOUR_1: next_state = in ? FIVE_1 : IDLE;
            FIVE_1: next_state = in ? SIX_1 : (in == 0 ? IDLE : FIVE_1);
            SIX_1: next_state = in ? SEVEN_1 : IDLE;
            SEVEN_1: next_state = in ? SEVEN_1 : IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (current_state)
                FIVE_1: begin
                    disc <= (in == 0);
                    flag <= 1'b0;
                    err <= 1'b0;
                end
                SIX_1: begin
                    disc <= 1'b0;
                    flag <= (in == 0);
                    err <= 1'b0;
                end
                SEVEN_1: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b1;
                end
                default: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end
            endcase
        end
    end

endmodule