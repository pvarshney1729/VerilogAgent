module TopModule(
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);
    logic state; // 0 for A, 1 for B

    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b1; // Reset to state B
        end else begin
            case (state)
                1'b1: begin // State B
                    if (in == 1'b0) 
                        state <= 1'b0; // Transition to A
                    // Stay in B if in == 1
                end
                1'b0: begin // State A
                    if (in == 1'b0) 
                        state <= 1'b1; // Transition to B
                    // Stay in A if in == 1
                end
            endcase
        end
    end

    // Output logic based on the current state
    assign out = state; // Output is 1 when in state B, 0 when in state A

endmodule