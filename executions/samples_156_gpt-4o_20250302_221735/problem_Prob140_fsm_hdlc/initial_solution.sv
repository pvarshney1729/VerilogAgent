module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S111 = 3'b011,
        S1111 = 3'b100,
        S11111 = 3'b101,
        S111110 = 3'b110,
        S111111 = 3'b111
    } state_t;

    state_t current_state, next_state;
    logic [2:0] one_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            one_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (in) begin
                one_count <= (one_count == 3'b111) ? one_count : one_count + 1;
            end else begin
                one_count <= 3'b000;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (in) next_state = S111;
                else next_state = IDLE;
            end
            S111: begin
                if (in) next_state = S1111;
                else next_state = IDLE;
            end
            S1111: begin
                if (in) next_state = S11111;
                else next_state = IDLE;
            end
            S11111: begin
                if (in) next_state = S111110;
                else next_state = IDLE;
            end
            S111110: begin
                if (in) next_state = S111111;
                else begin
                    next_state = IDLE;
                    disc = 1'b1;
                end
            end
            S111111: begin
                if (in) begin
                    next_state = S111111;
                    err = 1'b1;
                end else begin
                    next_state = IDLE;
                    flag = 1'b1;
                end
            end
        endcase
    end

endmodule