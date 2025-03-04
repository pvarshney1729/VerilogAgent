module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // Next-state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (w == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            STATE_C: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_D: next_state = (w == 1'b0) ? STATE_F : STATE_A;
            STATE_E: next_state = (w == 1'b0) ? STATE_E : STATE_D;
            STATE_F: next_state = (w == 1'b0) ? STATE_C : STATE_D;
            default: next_state = STATE_A;
        endcase
    end

    // State transition
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            Y1 <= 1'b0;
        else
            Y1 <= current_state[1];
    end

endmodule