module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic {OFF = 1'b0, ON = 1'b1} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            out <= (current_state == ON) ? 1'b1 : 1'b0;
        end
    end

    always_comb begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF; // Default case to avoid latches
        endcase
    end

endmodule