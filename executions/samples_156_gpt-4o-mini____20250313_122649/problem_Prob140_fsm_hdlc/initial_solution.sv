module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // 0
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7  // 0111111 (error state)
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (in == 1'b0) ? S1 : S0;
            S1: next_state = (in == 1'b1) ? S2 : S1;
            S2: next_state = (in == 1'b1) ? S3 : S1;
            S3: next_state = (in == 1'b1) ? S4 : S1;
            S4: next_state = (in == 1'b1) ? S5 : S1;
            S5: next_state = (in == 1'b1) ? S6 : S1;
            S6: next_state = (in == 1'b1) ? S7 : S1;
            S7: next_state = (in == 1'b1) ? S7 : S1; // Stay in error state
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S6: disc = 1'b1; // 0111110 detected
            S5: flag = 1'b1; // 01111110 detected
            S7: err = 1'b1;  // 01111111 detected
            default: ;
        endcase
    end

endmodule