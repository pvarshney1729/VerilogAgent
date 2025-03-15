module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0, // Initial state (waiting for 0)
        S1, // 0
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7  // 0111111 (Error state for 7 consecutive 1s)
    } state_t;

    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (in == 1'b0) ? S0 : S1;
            S1: next_state = (in == 1'b0) ? S0 : S2;
            S2: next_state = (in == 1'b0) ? S0 : S3;
            S3: next_state = (in == 1'b0) ? S0 : S4;
            S4: next_state = (in == 1'b0) ? S0 : S5;
            S5: next_state = (in == 1'b0) ? S0 : S6;
            S6: next_state = (in == 1'b0) ? S0 : S7; // Transition to error state on 7th 1
            S7: next_state = (in == 1'b0) ? S0 : S7; // Remain in error state
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (current_state)
            S5: disc = 1'b1; // Discard signal for 0111110
            S6: flag = 1'b1; // Flag signal for 01111110
            S7: err = 1'b1; // Error signal for 7 or more 1s
            default: ; // No outputs asserted
        endcase
    end

endmodule