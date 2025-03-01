module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B; // Default to state B
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1; // Default output for state B
        endcase
    end

endmodule