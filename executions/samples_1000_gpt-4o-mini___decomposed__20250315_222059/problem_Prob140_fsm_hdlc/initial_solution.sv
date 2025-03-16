module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0, // Initial state, expect 0
        S1, // First 1 received
        S2, // Second 1 received
        S3, // Third 1 received
        S4, // Fourth 1 received
        S5, // Fifth 1 received
        S6, // Sixth 1 received (flag)
        ERR // Error state for 7 or more 1s
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        disc = 0;
        flag = 0;
        err = 0;

        case (current_state)
            S0: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S0;
            end
            S6: begin
                if (in) begin
                    next_state = ERR; // Error state
                    err = 1; // Set error
                end else begin
                    disc = 1; // Discard on 0111110
                    next_state = S0;
                end
                flag = 1; // Found flag
            end
            ERR: begin
                if (!in) next_state = S0; // Reset on 0
            end
            default: next_state = S0;
        endcase
    end

endmodule