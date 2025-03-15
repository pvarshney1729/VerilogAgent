module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);
    // State encoding
    parameter logic A = 1'b0;
    parameter logic B = 1'b1;

    logic state; // Current state

    // State transition logic
    always @(*) begin
        case (state)
            B: begin
                if (in == 1'b0)
                    next_state = A; // Transition to A
                else
                    next_state = B; // Remain in B
            end
            A: begin
                if (in == 1'b0)
                    next_state = B; // Transition to B
                else
                    next_state = A; // Remain in A
            end
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            state <= B; // Reset to state B
        end else begin
            state <= next_state; // Update state
        end
    end

    // Output logic for Moore machine
    assign out = state; // Output is the current state

endmodule