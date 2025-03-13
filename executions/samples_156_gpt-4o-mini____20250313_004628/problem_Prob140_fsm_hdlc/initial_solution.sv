module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic in,
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
        S7, // 0111111 (error state)
        S8  // 01111110 (flag state)
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = (in == 1'b0) ? S1 : S0;
            S1: next_state = (in == 1'b0) ? S1 : S2;
            S2: next_state = (in == 1'b0) ? S1 : S3;
            S3: next_state = (in == 1'b0) ? S1 : S4;
            S4: next_state = (in == 1'b0) ? S1 : S5;
            S5: next_state = (in == 1'b0) ? S1 : S6;
            S6: next_state = (in == 1'b0) ? S1 : S7; // Error state
            S7: next_state = (in == 1'b0) ? S1 : S7; // Stay in error state
            S8: next_state = (in == 1'b0) ? S1 : S0; // Back to initial state after flag
            default: next_state = S0;
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            S6: disc = 1'b1; // Discard signal
            S8: flag = 1'b1; // Flag signal
            S7: err = 1'b1;  // Error signal
            default: begin
                disc = 1'b0;
                flag = 1'b0;
                err = 1'b0;
            end
        endcase
    end

endmodule