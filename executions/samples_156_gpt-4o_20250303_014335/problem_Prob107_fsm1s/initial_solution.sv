module TopModule (
    input logic clk,    // Clock signal, positive edge-triggered
    input logic reset,  // Active-high synchronous reset
    input logic in,     // Single-bit input
    output logic out    // Single-bit output
);

    typedef enum logic {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state;  // State register

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;  // Initialize state to B on reset
            out <= 1;
        end else begin
            case (state)
                STATE_B: begin
                    if (in == 1'b0) begin
                        state <= STATE_A;
                        out <= 1'b0;
                    end else begin
                        state <= STATE_B;
                        out <= 1'b1;
                    end
                end
                STATE_A: begin
                    if (in == 1'b0) begin
                        state <= STATE_B;
                        out <= 1'b1;
                    end else begin
                        state <= STATE_A;
                        out <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule