module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic {B, A} state_t;
    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
                out = 1'b1;
            end
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                out = 1'b0;
            end
            default: begin
                next_state = B;
                out = 1'b1; // Default output state
            end
        endcase
    end

endmodule