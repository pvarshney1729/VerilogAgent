module state_machine (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic state
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    always @(*) begin
        case (current_state)
            OFF: begin
                if (j && !k)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (!j && k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    assign state = (current_state == ON);

endmodule