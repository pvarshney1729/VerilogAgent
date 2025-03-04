module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        IDLE,
        S1,
        S2,
        S3,
        S4,
        S5,
        S6,
        DISC,
        FLAG,
        ERR
    } state_t;

    state_t current_state, next_state;
    logic [2:0] one_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            one_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == S6 && in == 1'b1) begin
                one_count <= one_count + 1;
            end else if (in == 1'b0) begin
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
                if (in == 1'b0) next_state = S1;
            end
            S1: begin
                if (in == 1'b1) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (in == 1'b1) next_state = S3;
                else next_state = S1;
            end
            S3: begin
                if (in == 1'b1) next_state = S4;
                else next_state = S1;
            end
            S4: begin
                if (in == 1'b1) next_state = S5;
                else next_state = S1;
            end
            S5: begin
                if (in == 1'b1) next_state = S6;
                else next_state = S1;
            end
            S6: begin
                if (in == 1'b0) next_state = DISC;
                else if (one_count >= 3'b110) next_state = ERR;
            end
            DISC: begin
                disc = 1'b1;
                next_state = IDLE;
            end
            FLAG: begin
                flag = 1'b1;
                next_state = IDLE;
            end
            ERR: begin
                err = 1'b1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase

        if (current_state == S6 && in == 1'b0) begin
            if (one_count == 3'b110) next_state = FLAG;
        end
    end

endmodule