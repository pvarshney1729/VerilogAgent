module TopModule(
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);
    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    // State register with asynchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic based on the current state
    assign out = (current_state == ON) ? 1'b1 : 1'b0;

    // Next state logic
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
endmodule