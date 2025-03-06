```verilog
module TopModule (
    input logic clk,          // Clock signal, 1-bit width
    input logic areset,       // Asynchronous reset signal, active high, 1-bit width
    input logic in,           // Input signal, 1-bit width
    output logic out          // Output signal, 1-bit width
);

    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (areset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Default to output for state B
        endcase
    end

endmodule
```