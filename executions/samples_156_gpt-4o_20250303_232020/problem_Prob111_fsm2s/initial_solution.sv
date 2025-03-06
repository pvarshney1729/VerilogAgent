module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
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
            default: next_state = OFF;
        endcase
    end

    // State register and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            case (next_state)
                OFF: out <= 1'b0;
                ON:  out <= 1'b1;
            endcase
        end
    end

endmodule