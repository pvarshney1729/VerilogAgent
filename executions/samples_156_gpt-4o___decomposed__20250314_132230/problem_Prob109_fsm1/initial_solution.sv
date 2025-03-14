module TopModule(
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic [1:0] {STATE_A = 2'b00, STATE_B = 2'b01} state_t;
    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            current_state <= STATE_B;
        else 
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule