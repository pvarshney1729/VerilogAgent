module fsm_101_detector (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after receiving '1'
        S2 = 2'b10  // State after receiving '10'
    } state_t;

    state_t current_state, next_state;

    // Sequential block for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational block for next state logic and output
    always @(*) begin
        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b0; // Output is 0
                end else begin
                    next_state = S0;
                    z = 1'b0; // Output is 0
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b0; // Output is 0
                end else begin
                    next_state = S2;
                    z = 1'b0; // Output is 0
                end
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Output is 1, sequence '101' detected
                end else begin
                    next_state = S0;
                    z = 1'b0; // Output is 0
                end
            end
            default: begin
                next_state = S0;
                z = 1'b0; // Default output
            end
        endcase
    end

endmodule