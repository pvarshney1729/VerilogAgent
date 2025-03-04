```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
            default: next_state = OFF; // Default case for safety
        endcase
    end

    // State update logic with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            current_state <= OFF;
        else 
            current_state <= next_state;
    end

    // Output logic based on current state
    assign out = (current_state == ON) ? 1'b1 : 1'b0;

endmodule
```