module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00, // State where shift_ena is low
        SHIFT_1 = 2'b01, // State for 1st cycle of shift_ena high
        SHIFT_2 = 2'b10, // State for 2nd cycle of shift_ena high
        SHIFT_3 = 2'b11  // State for 3rd cycle of shift_ena high
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SHIFT_1; // Start with shift_ena high for 4 cycles on reset
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE:    next_state = IDLE; // Remain in IDLE until reset
            SHIFT_1: next_state = SHIFT_2;
            SHIFT_2: next_state = SHIFT_3;
            SHIFT_3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign shift_ena = (current_state != IDLE);

endmodule