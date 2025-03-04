module TopModule (
    input  logic clk,      // Clock signal
    input  logic reset,    // Active-high synchronous reset
    input  logic j,        // Input signal j
    input  logic k,        // Input signal k
    output logic out       // Output signal out
);

    logic state; // State variable

    always @(posedge clk) begin
        if (reset) begin
            // Synchronous reset to OFF state
            state <= 1'b0;
            out <= 1'b0;
        end else begin
            case (state)
                1'b0: begin // OFF state
                    if (j) begin
                        state <= 1'b1; // Transition to ON
                        out <= 1'b1;
                    end
                    // Remain in OFF if j = 0
                end
                1'b1: begin // ON state
                    if (k) begin
                        state <= 1'b0; // Transition to OFF
                        out <= 1'b0;
                    end
                    // Remain in ON if k = 0
                end
            endcase
        end
    end

endmodule