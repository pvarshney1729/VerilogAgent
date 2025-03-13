[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic j,
    input  logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end
            end
        endcase
    end

    // Output logic
    assign out = (state == ON);

endmodule
```
[DONE]