module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
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

    // Output logic
    always_comb begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0; // Default case for safety
        endcase
    end

endmodule