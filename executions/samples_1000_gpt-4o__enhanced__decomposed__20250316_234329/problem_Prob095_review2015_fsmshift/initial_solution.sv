module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        ENABLE_1 = 3'b001,
        ENABLE_2 = 3'b010,
        ENABLE_3 = 3'b011,
        ENABLE_4 = 3'b100
    } state_t;

    // State register
    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE_1;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (reset)
                    next_state = ENABLE_1;
                else
                    next_state = IDLE;
            end
            ENABLE_1: next_state = ENABLE_2;
            ENABLE_2: next_state = ENABLE_3;
            ENABLE_3: next_state = ENABLE_4;
            ENABLE_4: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            ENABLE_1, ENABLE_2, ENABLE_3, ENABLE_4: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule