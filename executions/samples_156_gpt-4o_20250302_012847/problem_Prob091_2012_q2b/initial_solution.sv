module fsm_one_hot (
    input logic clk,
    input logic reset,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // State encoding using one-hot
    typedef enum logic [5:0] {
        S0 = 6'b000001,
        S1 = 6'b000010,
        S2 = 6'b000100,
        S3 = 6'b001000,
        S4 = 6'b010000,
        S5 = 6'b100000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = w ? S1 : S0;
            S1: next_state = w ? S2 : S1;
            S2: next_state = w ? S3 : S2;
            S3: next_state = w ? S4 : S3;
            S4: next_state = w ? S5 : S4;
            S5: next_state = w ? S0 : S5;
            default: next_state = S0;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    assign Y1 = current_state[1];
    assign Y3 = current_state[3];

endmodule