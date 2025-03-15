module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State transition logic with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        case (state)
            OFF: begin
                out = 1'b0;
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                out = 1'b1;
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end

endmodule