module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic out
);

    // State encoding
    typedef enum logic {B, A} state_t;
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            default: next_state = B; // default state
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1; // default output
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B; // reset to state B
        end else begin
            current_state <= next_state; // transition to next state
        end
    end

endmodule