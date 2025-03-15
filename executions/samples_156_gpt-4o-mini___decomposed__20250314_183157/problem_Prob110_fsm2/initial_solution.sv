module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic j,
    input  logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset) 
            current_state <= OFF;
        else 
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            OFF: begin
                out = 0;
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                out = 1;
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

endmodule