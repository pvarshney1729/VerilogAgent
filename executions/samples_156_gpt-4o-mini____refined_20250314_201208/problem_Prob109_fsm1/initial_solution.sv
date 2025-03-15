[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic in,
    output logic out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in) 
                    next_state = A;
                else 
                    next_state = B;
            end
            B: begin
                if (in) 
                    next_state = B;
                else 
                    next_state = A;
            end
            default: next_state = B; // Default state
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset) 
            state <= B;
        else 
            state <= next_state;
    end

    // Output logic
    assign out = (state == A) ? 1'b0 : 1'b1;

endmodule
```
[DONE]