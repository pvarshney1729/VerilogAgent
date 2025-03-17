module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        S_IDLE = 3'b000,
        S_1    = 3'b001,
        S_11   = 3'b010,
        S_111  = 3'b011,
        S_1111 = 3'b100,
        S_11111 = 3'b101,
        S_111110 = 3'b110,
        S_111111 = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        case (current_state)
            S_IDLE: begin
                if (in) next_state = S_1;
            end
            S_1: begin
                if (in) next_state = S_11;
                else next_state = S_IDLE;
            end
            S_11: begin
                if (in) next_state = S_111;
                else next_state = S_IDLE;
            end
            S_111: begin
                if (in) next_state = S_1111;
                else next_state = S_IDLE;
            end
            S_1111: begin
                if (in) next_state = S_11111;
                else next_state = S_IDLE;
            end
            S_11111: begin
                if (in) next_state = S_111110;
                else next_state = S_IDLE;
            end
            S_111110: begin
                if (in) begin
                    next_state = S_111111;
                    flag = 1'b1;
                end else begin
                    next_state = S_IDLE;
                    disc = 1'b1;
                end
            end
            S_111111: begin
                if (in) begin
                    err = 1'b1;
                end else begin
                    next_state = S_IDLE;
                end
            end
            default: next_state = S_IDLE;
        endcase
    end

endmodule