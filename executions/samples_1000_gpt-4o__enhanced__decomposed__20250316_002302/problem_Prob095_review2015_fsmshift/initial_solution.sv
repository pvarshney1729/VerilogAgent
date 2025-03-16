module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        ENABLE1 = 3'b001,
        ENABLE2 = 3'b010,
        ENABLE3 = 3'b011,
        ENABLE4 = 3'b100
    } state_t;

    // Internal state registers
    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= ENABLE1;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:    next_state = IDLE;
            ENABLE1: next_state = ENABLE2;
            ENABLE2: next_state = ENABLE3;
            ENABLE3: next_state = ENABLE4;
            ENABLE4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            ENABLE1, ENABLE2, ENABLE3, ENABLE4: shift_ena = 1'b1;
            default:                            shift_ena = 1'b0;
        endcase
    end

endmodule