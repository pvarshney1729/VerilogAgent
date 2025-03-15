```verilog
module TopModule (
    input logic clk,
    input logic reset_n,
    output logic [3:0] state,
    output logic output_signal
);

    // State encoding using 4-bit one-hot encoding
    typedef enum logic [3:0] {
        S0 = 4'b0001,
        S1 = 4'b0010,
        S2 = 4'b0100,
        S3 = 4'b1000
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (!reset_n) begin
            current_state <= S0; // Reset to initial state S0
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = S0; // Default case
        endcase
    end

    // Output logic
    assign output_signal = (current_state == S2) ? 1'b1 : 1'b0;

    // Assign state output
    assign state = current_state;

endmodule
```