```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State Encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    // Current State Register
    state_t current_state, next_state;

    // Sequential Logic: State Transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational Logic: Determine Next State and Output
    always @(*) begin
        case (current_state)
            STATE_B: begin
                out = 1;
                next_state = (in == 0) ? STATE_A : STATE_B;
            end
            STATE_A: begin
                out = 0;
                next_state = (in == 0) ? STATE_B : STATE_A;
            end
            default: begin
                out = 1; // Default to State B output
                next_state = STATE_B; // Default to reset state
            end
        endcase
    end

endmodule
```