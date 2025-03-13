module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic {A, B} state_t;
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

    // State update logic with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= B; // Asynchronous reset to state B
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // Output logic (Moore machine output)
    assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule