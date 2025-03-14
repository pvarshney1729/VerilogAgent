[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        SHIFT_1 = 3'b001,
        SHIFT_2 = 3'b010,
        SHIFT_3 = 3'b011,
        SHIFT_4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SHIFT_1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE:    next_state = IDLE;
            SHIFT_1: next_state = SHIFT_2;
            SHIFT_2: next_state = SHIFT_3;
            SHIFT_3: next_state = SHIFT_4;
            SHIFT_4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            SHIFT_1, SHIFT_2, SHIFT_3, SHIFT_4: shift_ena = 1'b1;
            default:                            shift_ena = 1'b0;
        endcase
    end

endmodule
[DONE]