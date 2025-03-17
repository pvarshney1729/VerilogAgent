module TopModule(
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic {OFF = 1'b0, ON = 1'b1} state_t;
    state_t current_state, next_state;

    // State transition logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

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
            default: next_state = OFF; // Default to OFF state
        endcase
    end

    // Output logic
    assign out = (current_state == ON) ? 1'b1 : 1'b0;

endmodule