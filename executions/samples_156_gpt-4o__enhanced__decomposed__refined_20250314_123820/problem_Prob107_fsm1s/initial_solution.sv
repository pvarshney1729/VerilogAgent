[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            STATE_A: begin
                out = 1'b0;
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                out = 1'b1;
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: begin
                out = 1'b1;
                next_state = STATE_B;
            end
        endcase
    end

endmodule
[DONE]