module TopModule (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic reset,          // Active-high synchronous reset
    input logic data,           // Serial input data stream
    output logic start_shifting  // Output signal set high upon sequence detection
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        S1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
            if (next_state == S1101) begin
                start_shifting <= 1'b1;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (data) begin
                    next_state = S1;
                end else begin
                    next_state = IDLE;
                end
            end
            S1: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = IDLE;
                end
            end
            S11: begin
                if (~data) begin
                    next_state = S110;
                end else begin
                    next_state = S11;
                end
            end
            S110: begin
                if (data) begin
                    next_state = S1101;
                end else begin
                    next_state = S1;
                end
            end
            S1101: begin
                next_state = S1101; // Remain in S1101 until reset
            end
            default: next_state = IDLE; // Safety default
        endcase
    end

endmodule