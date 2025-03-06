```
[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State Encoding
    localparam logic STATE_A = 1'b0;
    localparam logic STATE_B = 1'b1;

    // State Variable
    logic current_state, next_state;

    // State Transition Logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset to State B
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            STATE_B: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_A: next_state = (in == 1'b0) ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default to State B for safety
        endcase
    end

    // Output Logic
    always_comb begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default output for safety
        endcase
    end

endmodule
[DONE]
```