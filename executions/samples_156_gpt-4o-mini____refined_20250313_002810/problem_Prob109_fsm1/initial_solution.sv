```
[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B; // Default to state B
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset) 
            state <= B; // Synchronous reset to state B
        else 
            state <= next_state;
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
[DONE]
```