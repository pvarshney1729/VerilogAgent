```
[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    localparam STATE_A = 1'b0;
    localparam STATE_B = 1'b1;

    // State register
    logic current_state, next_state;

    // Asynchronous reset and state transition logic
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_B: next_state = in ? STATE_B : STATE_A;
            STATE_A: next_state = in ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default safe state
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b1; // Default safe output aligned with state B
        endcase
    end

endmodule
[DONE]
```