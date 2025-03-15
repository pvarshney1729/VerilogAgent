module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4, S5, S6, S7
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
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
                else begin
                    next_state = S0;
                    disc = 1'b1;
                end
            end
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S0;
                    flag = 1'b1;
                end
            end
            S7: begin
                if (in) next_state = S7;
                else next_state = S0;
                err = 1'b1;
            end
            default: next_state = S0;
        endcase
    end

endmodule