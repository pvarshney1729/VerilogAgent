module TopModule (
    input logic clk,       // Clock input, active on rising edge
    input logic reset,     // Active-high synchronous reset
    input logic in,        // Single-bit input signal
    output logic out       // Single-bit output signal
);

    // State encoding
    typedef enum logic {
        B = 1'b0, // Reset state
        A = 1'b1  // Other state
    } state_t;

    state_t current_state;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            // On reset, go to state B
            current_state <= B;
            out <= 1'b1;
        end else begin
            case (current_state)
                B: begin
                    out <= 1'b1;
                    if (in == 1'b0)
                        current_state <= A;
                    else
                        current_state <= B;
                end
                A: begin
                    out <= 1'b0;
                    if (in == 1'b0)
                        current_state <= B;
                    else
                        current_state <= A;
                end
            endcase
        end
    end

endmodule