module TopModule (
    input logic clk,       // Clock input
    input logic reset,     // Active-high synchronous reset
    input logic in,        // Input signal for state transitions
    output logic out       // Output signal representing the state output
);

    // State encoding
    typedef enum logic {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state;

    always_ff @(posedge clk) begin
        if (reset) begin
            // Synchronous reset behavior
            state <= STATE_B;
            out <= 1'b1;
        end else begin
            case (state)
                STATE_B: begin
                    out <= 1'b1;
                    if (in == 1'b0)
                        state <= STATE_A; // Transition to State A
                    else
                        state <= STATE_B; // Remain in State B
                end
                STATE_A: begin
                    out <= 1'b0;
                    if (in == 1'b0)
                        state <= STATE_B; // Transition to State B
                    else
                        state <= STATE_A; // Remain in State A
                end
            endcase
        end
    end

endmodule