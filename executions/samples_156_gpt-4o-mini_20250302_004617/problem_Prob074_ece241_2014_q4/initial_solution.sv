module fsm (
    input logic clk,
    input logic reset,
    input logic din,
    output logic dout
);

    logic state, next_state;

    // State encoding
    localparam S0 = 1'b0, S1 = 1'b1;

    // D flip-flop for state storage
    always @(posedge clk) begin
        if (reset) begin
            state <= 1'b0; // Initialize state to S0 on reset
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (din) begin
                    next_state = S1; // Transition to S1 on din = 1
                end else begin
                    next_state = S0; // Stay in S0
                end
            end
            S1: begin
                if (din) begin
                    next_state = S0; // Transition to S0 on din = 1
                end else begin
                    next_state = S1; // Stay in S1
                end
            end
            default: next_state = S0; // Default state
        endcase
    end

    // Output logic
    assign dout = state ^ din; // XOR operation for output

endmodule