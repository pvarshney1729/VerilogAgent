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
        S0, // Initial state
        S1, // 0
        S2, // 01
        S3, // 011
        S4, // 0111
        S5, // 01111
        S6, // 011111
        S7  // 0111111 (error state)
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
        case (current_state)
            S0: begin
                if (in) next_state = S1;
                else next_state = S0;
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
                if (in) next_state = S7; // Error state
                else next_state = S0; // Discard
            end
            S7: begin
                next_state = S7; // Stay in error state
            end
            default: next_state = S0;
        endcase
    end

    always_ff @(posedge clk) begin
        disc <= 0;
        flag <= 0;
        err <= 0;

        if (current_state == S6 && !in) begin
            disc <= 1; // Signal discard
        end else if (current_state == S6 && in) begin
            flag <= 1; // Signal flag
        end else if (current_state == S7) begin
            err <= 1; // Signal error
        end
    end
endmodule