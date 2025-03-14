module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic out
);

    // State encoding
    typedef enum logic [0:0] {A = 1'b0, B = 1'b1} state_t;
    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (current_state)
            B: begin
                out = 1'b1;
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            A: begin
                out = 1'b0;
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            default: begin
                out = 1'bx; // Undefined state output
                next_state = B; // Default to reset state
            end
        endcase
    end

endmodule