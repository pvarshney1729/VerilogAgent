```verilog
module TopModule (
    input logic clk,        // Clock signal
    input logic reset,      // Active-high synchronous reset
    input logic in,         // Input signal
    output logic out        // Output signal
);

    typedef enum logic [1:0] {
        STATE_B = 2'b01,    // State B
        STATE_A = 2'b10     // State A
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_B: begin
                out = 1;
                if (in == 0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                out = 0;
                if (in == 0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: begin
                out = 1;
                next_state = STATE_B;
            end
        endcase
    end

    // State register logic
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

endmodule
```