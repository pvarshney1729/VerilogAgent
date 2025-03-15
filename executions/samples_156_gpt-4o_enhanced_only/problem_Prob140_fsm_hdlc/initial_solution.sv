module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0, // Initial state, as if previous input was '0'
        S1, // Seen 0
        S2, // Seen 01
        S3, // Seen 011
        S4, // Seen 0111
        S5, // Seen 01111
        S6, // Seen 011111
        S7  // Seen 0111111
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output logic
    always_comb begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

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
                if (in) next_state = S7;
                else begin
                    next_state = S0;
                    disc = 1'b1;
                end
            end
            S7: begin
                if (in) begin
                    next_state = S7;
                    err = 1'b1;
                end else begin
                    next_state = S0;
                    flag = 1'b1;
                end
            end
            default: next_state = S0;
        endcase
    end

endmodule