```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {STATE_B = 2'b01, STATE_A = 2'b10} state_t;
    state_t current_state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                out = 1'b1;
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_A: begin
                out = 1'b0;
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_B;
            end
        endcase
    end

endmodule
```