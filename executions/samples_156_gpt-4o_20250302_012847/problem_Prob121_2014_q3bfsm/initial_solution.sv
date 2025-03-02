module fsm (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [2:0] {
        STATE_0 = 3'b000,
        STATE_1 = 3'b001,
        STATE_2 = 3'b010,
        STATE_3 = 3'b011,
        STATE_4 = 3'b100,
        STATE_5 = 3'b101,
        STATE_6 = 3'b110,
        STATE_7 = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = in ? STATE_1 : STATE_0;
            STATE_1: next_state = in ? STATE_2 : STATE_0;
            STATE_2: next_state = in ? STATE_3 : STATE_0;
            STATE_3: next_state = in ? STATE_4 : STATE_0;
            STATE_4: next_state = in ? STATE_5 : STATE_0;
            STATE_5: next_state = in ? STATE_6 : STATE_0;
            STATE_6: next_state = in ? STATE_7 : STATE_0;
            STATE_7: next_state = in ? STATE_0 : STATE_0;
            default: next_state = STATE_0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_0: out = 1'b0;
            STATE_1: out = 1'b0;
            STATE_2: out = 1'b0;
            STATE_3: out = 1'b0;
            STATE_4: out = 1'b0;
            STATE_5: out = 1'b0;
            STATE_6: out = 1'b0;
            STATE_7: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // State register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

endmodule