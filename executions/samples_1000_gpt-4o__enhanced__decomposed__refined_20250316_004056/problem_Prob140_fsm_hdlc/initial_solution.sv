module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,  // Initial state, equivalent to 0 previous 1s
        S1 = 3'b001,  // 1 consecutive 1
        S2 = 3'b010,  // 2 consecutive 1s
        S3 = 3'b011,  // 3 consecutive 1s
        S4 = 3'b100,  // 4 consecutive 1s
        S5 = 3'b101,  // 5 consecutive 1s
        S6 = 3'b110,  // 6 consecutive 1s
        S7 = 3'b111   // 7 or more consecutive 1s (error state)
    } state_t;

    state_t current_state, next_state;

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S0;
            S2: next_state = (in) ? S3 : S0;
            S3: next_state = (in) ? S4 : S0;
            S4: next_state = (in) ? S5 : S0;
            S5: next_state = (in) ? S6 : S0;
            S6: next_state = (in) ? S7 : S0;
            S7: next_state = (in) ? S7 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic based on current state
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;

        case (current_state)
            S5: if (!in) disc = 1'b1; // 0111110 detected
            S6: if (!in) flag = 1'b1; // 01111110 detected
            S7: if (in) err = 1'b1;   // 01111111... detected
            default: begin
                disc = 1'b0;
                flag = 1'b0;
                err  = 1'b0;
            end
        endcase
    end

endmodule