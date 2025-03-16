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

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (current_state)
            S0: begin
                if (in == 1'b1) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (in == 1'b1) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in == 1'b1) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in == 1'b1) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in == 1'b1) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in == 1'b1) next_state = S6;
                else next_state = S0;
            end
            S6: begin
                if (in == 1'b1) next_state = S7; // Error state
                else next_state = S8; // Flag state
            end
            S7: begin
                err = 1'b1; // Error output
                next_state = S7; // Remain in error state
            end
            S8: begin
                flag = 1'b1; // Flag output
                next_state = S0; // Go back to initial state
            end
            default: next_state = S0;
        endcase

        // Handle disc output
        if (current_state == S6 && in == 1'b0) begin
            disc = 1'b1; // Signal to discard
        end
    end

endmodule