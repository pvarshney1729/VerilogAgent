module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A  = 3'b000,  // Reset state
        STATE_B1 = 3'b001,  // First cycle in state B
        STATE_B2 = 3'b010,  // Second cycle in state B
        STATE_B3 = 3'b011,  // Third cycle in state B
        STATE_C  = 3'b100   // Output state
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for w = 1 occurrences

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B1 || current_state == STATE_B2 || current_state == STATE_B3) begin
                if (w) w_count <= w_count + 1;
            end
            if (current_state == STATE_C) begin
                if (w_count == 2'b10) z <= 1'b1;
                else z <= 1'b0;
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) next_state = STATE_B1;
                else next_state = STATE_A;
            end
            STATE_B1: next_state = STATE_B2;
            STATE_B2: next_state = STATE_B3;
            STATE_B3: next_state = STATE_C;
            STATE_C: next_state = STATE_B1;
            default: next_state = STATE_A;
        endcase
    end

endmodule