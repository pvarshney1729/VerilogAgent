module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == S4) begin
                start_shifting <= 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: begin
                if (data) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (data) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (data) next_state = S2;
                else next_state = S3;
            end
            S3: begin
                if (data) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                next_state = S4; // Remain in S4 until reset
            end
            default: next_state = S0;
        endcase
    end

endmodule