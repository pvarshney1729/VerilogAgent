module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    // State register
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: begin
                out = 1'b0;
                if (j == 1'b1)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                out = 1'b1;
                if (k == 1'b1)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: begin
                next_state = OFF;
                out = 1'b0;
            end
        endcase
    end

    // State register update
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

endmodule