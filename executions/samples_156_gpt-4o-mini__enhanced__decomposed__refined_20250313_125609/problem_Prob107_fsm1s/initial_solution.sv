```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    parameter STATE_B = 1'b0; // State B
    parameter STATE_A = 1'b1; // State A
    
    logic state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;
            out <= 1'b1;
        end else begin
            state <= next_state;
            out <= (next_state == STATE_B) ? 1'b1 : 1'b0;
        end
    end

    always @(*) begin
        case (state)
            STATE_B: begin
                next_state = (in == 1'b0) ? STATE_A : STATE_B;
            end
            
            STATE_A: begin
                next_state = (in == 1'b0) ? STATE_B : STATE_A;
            end
            
            default: next_state = STATE_B; // Default case for safety
        endcase
    end

endmodule
[DONE]
```