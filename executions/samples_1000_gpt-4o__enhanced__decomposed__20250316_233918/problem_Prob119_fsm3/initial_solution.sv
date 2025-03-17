module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    localparam logic [1:0] STATE_A = 2'b00,
                           STATE_B = 2'b01,
                           STATE_C = 2'b10,
                           STATE_D = 2'b11;

    // State register
    logic [1:0] state, next_state;

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_B: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            STATE_C: next_state = (in == 1'b0) ? STATE_A : STATE_D;
            STATE_D: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            default: next_state = STATE_A; // Default to state A for safety
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule