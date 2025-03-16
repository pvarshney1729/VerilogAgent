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
        S0, // Initial state, equivalent to having seen a '0'
        S1, // Seen '01'
        S2, // Seen '011'
        S3, // Seen '0111'
        S4, // Seen '01111'
        S5, // Seen '011111'
        S6, // Seen '0111111'
        S7  // Seen '01111111' or more
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;
        next_state = current_state;

        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: begin
                if (in) next_state = S6;
                else begin
                    next_state = S0;
                    disc = 1'b1; // 0111110 detected
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                    flag = 1'b1; // 01111110 detected
                end else begin
                    next_state = S0;
                    flag = 1'b1; // 01111110 detected
                end
            end
            S7: begin
                if (in) begin
                    next_state = S7;
                    err = 1'b1; // 01111111... detected
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule