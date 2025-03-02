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
        S1, // Received 1
        S2, // Received 11
        S3, // Received 111
        S4, // Received 1111
        S5, // Received 11111
        S6, // Received 111111
        S7  // Error state (7 or more 1s)
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
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

    // State update logic with synchronous reset
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
            S6: begin
                disc = 1'b1; // 0111110 detected
            end
            S7: begin
                err = 1'b1; // 01111111... detected
            end
            default: begin
                if (current_state == S5 && in) begin
                    flag = 1'b1; // 01111110 detected
                end
            end
        endcase
    end

endmodule