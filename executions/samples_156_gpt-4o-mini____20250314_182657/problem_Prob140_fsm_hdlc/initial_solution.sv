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

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S0: begin
                if (in == 1'b1) next_state = S1;
            end
            S1: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S2;
            end
            S2: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S3;
            end
            S3: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S4;
            end
            S4: begin
                if (in == 1'b0) next_state = S0;
                else next_state = S5;
            end
            S5: begin
                if (in == 1'b0) begin
                    disc = 1'b1; // Need to discard
                    next_state = S0;
                end else next_state = S6;
            end
            S6: begin
                if (in == 1'b0) begin
                    flag = 1'b1; // Flag detected
                    next_state = S0;
                end else begin
                    next_state = S7; // Error state
                end
            end
            S7: begin
                err = 1'b1; // Error state
                if (in == 1'b0) next_state = S0; // Reset to initial state
                else next_state = S7; // Stay in error state
            end
        endcase
    end

endmodule