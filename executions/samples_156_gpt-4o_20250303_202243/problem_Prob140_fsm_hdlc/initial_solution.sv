module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        S1          = 3'b001,
        S11         = 3'b010,
        S111        = 3'b011,
        S1111       = 3'b100,
        S11111      = 3'b101,
        DISC_DETECT = 3'b110,
        FLAG_DETECT = 3'b111,
        ERR_DETECT  = 3'b000
    } state_t;

    state_t current_state, next_state;
    logic [2:0] count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == S11111 && in == 1'b1) begin
                count <= count + 1;
            end else begin
                count <= 3'b000;
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
                if (in == 1'b0) next_state = S1;
            end
            S1: begin
                if (in == 1'b1) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (in == 1'b1) next_state = S111;
                else next_state = IDLE;
            end
            S111: begin
                if (in == 1'b1) next_state = S1111;
                else next_state = IDLE;
            end
            S1111: begin
                if (in == 1'b1) next_state = S11111;
                else next_state = IDLE;
            end
            S11111: begin
                if (in == 1'b0) next_state = DISC_DETECT;
                else if (count >= 3'b110) next_state = ERR_DETECT;
            end
            DISC_DETECT: begin
                disc = 1'b1;
                next_state = IDLE;
            end
            FLAG_DETECT: begin
                flag = 1'b1;
                next_state = IDLE;
            end
            ERR_DETECT: begin
                err = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule