module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    localparam logic STATE_A = 1'b0;
    localparam logic STATE_B = 1'b1;

    // State register
    logic state, next_state;

    // State transition logic with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B; // Asynchronous reset to state B
        else
            state <= next_state;
    end

    // Combinational logic for next state
    always_comb begin
        case (state)
            STATE_A: next_state = in ? STATE_A : STATE_B;
            STATE_B: next_state = in ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // Output logic based on current state
    always_comb begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b0; // Default case for safety
        endcase
    end

endmodule