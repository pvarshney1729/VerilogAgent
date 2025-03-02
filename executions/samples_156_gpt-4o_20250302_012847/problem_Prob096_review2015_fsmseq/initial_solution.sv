```verilog
module sequence_detector_1101 (
    input logic clk,
    input logic reset,
    input logic in,
    output logic detected
);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // State after detecting '1'
        S2, // State after detecting '11'
        S3, // State after detecting '110'
        S4  // State after detecting '1101'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S2 : S3;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S2 : S0;
            default: next_state = S0;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        detected = (current_state == S4);
    end

endmodule
```