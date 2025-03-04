```verilog
module TopModule (
    input  logic clk,       // Clock signal, rising edge triggered
    input  logic reset,     // Active-high synchronous reset
    input  logic in,        // Input signal for state transitions
    output logic out        // Output signal, driven by the current state
);

    // State encoding
    typedef enum logic {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_B; // Initialize to State B on reset
            out <= 1'b1;
        end else begin
            case (state)
                STATE_B: begin
                    if (in == 1'b0) begin
                        state <= STATE_A; // Transition to State A
                        out <= 1'b0;
                    end
                end
                STATE_A: begin
                    if (in == 1'b0) begin
                        state <= STATE_B; // Transition to State B
                        out <= 1'b1;
                    end
                end
            endcase
        end
    end

endmodule
```