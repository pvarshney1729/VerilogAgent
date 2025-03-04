module TopModule (
    logic clk,
    logic reset,
    logic in,
    logic out
);

    typedef enum logic [0:0] {B = 1'b0, A = 1'b1} state_t;
    state_t current_state, next_state;

    // State Transition and Output Logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
            out <= 1'b1;
        end else begin
            current_state <= next_state;
            case (next_state)
                B: out <= 1'b1;
                A: out <= 1'b0;
            endcase
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
            default: next_state = B; // Default state for safety
        endcase
    end

endmodule