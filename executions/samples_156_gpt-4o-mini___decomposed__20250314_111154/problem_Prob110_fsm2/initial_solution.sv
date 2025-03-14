module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF, ON} state_t;
    state_t current_state, next_state;

    always @(posedge clk) begin
        if (areset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            OFF: begin
                next_state = (j) ? ON : OFF;
                out = 1'b0;
            end
            ON: begin
                next_state = (k) ? OFF : ON;
                out = 1'b1;
            end
        endcase
    end

endmodule