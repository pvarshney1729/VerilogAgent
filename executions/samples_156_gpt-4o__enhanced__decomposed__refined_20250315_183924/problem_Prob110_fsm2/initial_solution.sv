```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);
    // State encoding
    typedef enum logic {OFF = 1'b0, ON = 1'b1} state_t;
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
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
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
        endcase
    end
endmodule
```