module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = B; // Default to state B
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Default case to handle any unforeseen states
        endcase
    end

endmodule