module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        STATE_0 = 4'b0000,
        STATE_1 = 4'b0001,
        STATE_2 = 4'b0010,
        STATE_3 = 4'b0011,
        STATE_4 = 4'b0100,
        STATE_5 = 4'b0101,
        STATE_6 = 4'b0110,
        STATE_7 = 4'b0111,
        STATE_8 = 4'b1000,
        STATE_9 = 4'b1001,
        STATE_ERR = 4'b1010
    } state_t;

    state_t current_state, next_state;
    logic [3:0] count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
            count <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state >= STATE_2 && current_state <= STATE_ERR) begin
                count <= count + (in ? 1 : 0);
            end else begin
                count <= (in ? 4'b0001 : 4'b0000);
            end
        end
    end

    always_ff @(posedge clk) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;

        case (current_state)
            STATE_0: begin
                if (in == 1'b0) next_state <= STATE_1;
                else next_state <= STATE_0;
            end
            STATE_1: begin
                if (in == 1'b1) next_state <= STATE_2;
                else next_state <= STATE_0;
            end
            STATE_2: next_state <= (in ? STATE_3 : STATE_0);
            STATE_3: next_state <= (in ? STATE_4 : STATE_0);
            STATE_4: next_state <= (in ? STATE_5 : STATE_0);
            STATE_5: next_state <= (in ? STATE_6 : STATE_0);
            STATE_6: next_state <= (in ? STATE_7 : STATE_0);
            STATE_7: begin
                if (in == 1'b0) begin
                    disc <= 1'b1;
                    next_state <= STATE_8;
                end else begin
                    flag <= 1'b1;
                    next_state <= STATE_9;
                end
            end
            STATE_8: begin
                next_state <= STATE_0;
            end
            STATE_9: begin
                next_state <= STATE_0;
            end
            default: begin
                if (count >= 4'b0111) begin
                    err <= 1'b1;
                    next_state <= STATE_0;
                end else begin
                    next_state <= STATE_0;
                end
            end
        endcase
    end

endmodule