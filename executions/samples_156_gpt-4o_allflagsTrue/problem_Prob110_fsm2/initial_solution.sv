module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic [0:0] {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State transition logic with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        case (state)
            OFF: begin
                out = 1'b0;
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                out = 1'b1;
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: begin
                out = 1'b0;
                next_state = OFF;
            end
        endcase
    end

endmodule