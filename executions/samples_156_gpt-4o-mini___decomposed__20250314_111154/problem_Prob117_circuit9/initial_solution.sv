module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    typedef enum logic [2:0] {
        STATE_0 = 3'b000,
        STATE_1 = 3'b001,
        STATE_4 = 3'b100,
        STATE_5 = 3'b101,
        STATE_6 = 3'b110
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            STATE_0: next_state = (a) ? STATE_1 : STATE_0;
            STATE_1: next_state = (a) ? STATE_4 : STATE_0;
            STATE_4: next_state = (a) ? STATE_4 : STATE_5;
            STATE_5: next_state = (a) ? STATE_6 : STATE_0;
            STATE_6: next_state = (a) ? STATE_0 : STATE_6;
            default: next_state = STATE_0;
        endcase
    end

    assign q = current_state;

endmodule