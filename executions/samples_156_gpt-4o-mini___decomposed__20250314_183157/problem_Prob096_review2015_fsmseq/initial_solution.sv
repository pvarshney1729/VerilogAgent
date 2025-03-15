module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);
    // State encoding
    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Got 1
        S2, // Got 11
        S3, // Got 110
        S4  // Got 1101
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            S0: next_state = (data) ? S1 : S0;
            S1: next_state = (data) ? S2 : S0;
            S2: next_state = (data) ? S3 : S0;
            S3: next_state = (data) ? S4 : S0;
            S4: begin
                next_state = S4; // Remain in S4 after detecting 1101
                start_shifting = 1;
            end
            default: next_state = S0;
        endcase
    end
endmodule