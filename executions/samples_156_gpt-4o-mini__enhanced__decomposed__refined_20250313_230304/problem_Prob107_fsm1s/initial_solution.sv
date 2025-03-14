[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);
    typedef enum logic {B, A} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            B: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            A: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B; // Default to state B
        endcase
    end

    assign out = (current_state == B) ? 1'b1 : 1'b0; // Output logic

endmodule
```
[DONE]