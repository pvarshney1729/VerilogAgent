module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        S_IDLE      = 4'b0000,
        S_0         = 4'b0001,
        S_01        = 4'b0010,
        S_011       = 4'b0011,
        S_0111      = 4'b0100,
        S_01111     = 4'b0101,
        S_011111    = 4'b0110,
        S_0111111   = 4'b0111,
        S_01111110  = 4'b1000,
        S_ERROR     = 4'b1001
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            S_IDLE: begin
                if (in == 1'b0) next_state = S_0;
                else next_state = S_IDLE;
            end
            S_0: begin
                if (in == 1'b1) next_state = S_01;
                else next_state = S_IDLE;
            end
            S_01: begin
                if (in == 1'b1) next_state = S_011;
                else next_state = S_IDLE;
            end
            S_011: begin
                if (in == 1'b1) next_state = S_0111;
                else next_state = S_IDLE;
            end
            S_0111: begin
                if (in == 1'b1) next_state = S_01111;
                else next_state = S_IDLE;
            end
            S_01111: begin
                if (in == 1'b1) next_state = S_011111;
                else next_state = S_IDLE;
            end
            S_011111: begin
                if (in == 1'b1) next_state = S_0111111;
                else begin
                    next_state = S_IDLE;
                    disc = 1'b1;
                end
            end
            S_0111111: begin
                if (in == 1'b0) begin
                    next_state = S_01111110;
                    flag = 1'b1;
                end else begin
                    next_state = S_ERROR;
                    err = 1'b1;
                end
            end
            S_01111110: begin
                next_state = S_IDLE;
            end
            S_ERROR: begin
                next_state = S_IDLE;
            end
            default: next_state = S_IDLE;
        endcase
    end

endmodule