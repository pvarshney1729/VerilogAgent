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

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        out = 1'b0; // Default output

        case (current_state)
            B: begin
                if (in) begin
                    next_state = B;
                    out = 1'b1;
                end else begin
                    next_state = A;
                    out = 1'b1;
                end
            end
            A: begin
                if (in) begin
                    next_state = A;
                    out = 1'b0;
                end else begin
                    next_state = B;
                    out = 1'b0;
                end
            end
        endcase
    end

endmodule
```
[DONE]