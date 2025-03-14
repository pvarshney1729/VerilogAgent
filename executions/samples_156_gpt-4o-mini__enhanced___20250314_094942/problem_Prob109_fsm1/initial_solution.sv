module TopModule (
    input logic clk,            // Clock signal (1-bit input, rising edge-triggered)
    input logic areset,        // Asynchronous reset (1-bit input, active high)
    input logic in,            // Input signal (1-bit input, unsigned)
    output logic out           // Output signal (1-bit output, unsigned)
);

    logic current_state; // State variable

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 1'b1;           // Reset to state B
            current_state <= 1'b1; // State B
        end else begin
            case (current_state)
                1'b1: begin // State B
                    if (in) begin
                        out <= 1'b1; // Remain in State B
                    end else begin
                        out <= 1'b0; // Transition to State A
                        current_state <= 1'b0; // State A
                    end
                end
                1'b0: begin // State A
                    if (in) begin
                        out <= 1'b0; // Remain in State A
                    end else begin
                        out <= 1'b1; // Transition to State B
                        current_state <= 1'b1; // State B
                    end
                end
                default: begin
                    out <= 1'b0; // Default case
                    current_state <= 1'b0; // Default state
                end
            endcase
        end
    end
endmodule