module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        IDLE,
        S0,
        S01,
        S011,
        S0111,
        S01111,
        S011111,
        S0111110,
        S01111110,
        ERROR
    } state_t;

    state_t current_state, next_state;
    logic [7:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            shift_reg <= {shift_reg[6:0], in};
        end
    end

    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (shift_reg[6:0] == 7'b0111111 && in == 1'b0) begin
                    next_state = S0111110;
                end else if (shift_reg[6:0] == 7'b1111111) begin
                    next_state = ERROR;
                end else if (shift_reg[5:0] == 6'b111111 && in == 1'b0) begin
                    next_state = S01111;
                end else if (shift_reg[5:0] == 6'b111111 && in == 1'b1) begin
                    next_state = S011111;
                end
            end
            S01111: begin
                if (in == 1'b0) begin
                    disc = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = S011111;
                end
            end
            S0111110: begin
                if (in == 1'b0) begin
                    flag = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = S011111;
                end
            end
            S011111: begin
                if (in == 1'b1) begin
                    next_state = ERROR;
                end else begin
                    next_state = IDLE;
                end
            end
            ERROR: begin
                err = 1'b1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule