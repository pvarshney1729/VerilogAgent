module sequence_detector (
    input logic clk,
    input logic rst,
    input logic din,
    output logic detected
);

    typedef enum logic [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // State after receiving '1'
        S2 = 2'b10, // State after receiving '10'
        S3 = 2'b11  // State after receiving '101'
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (rst) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (din) ? S1 : S0;
            S1: next_state = (din) ? S1 : S2;
            S2: next_state = (din) ? S3 : S0;
            S3: next_state = (din) ? S1 : S2; // Loop back to S1 or S2
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign detected = (current_state == S3);

endmodule