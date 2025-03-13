[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_0 = 3'b000,
        STATE_1 = 3'b001,
        STATE_2 = 3'b010,
        STATE_3 = 3'b011,
        STATE_4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = (data) ? STATE_1 : STATE_0;
            STATE_1: next_state = (data) ? STATE_2 : STATE_0;
            STATE_2: next_state = (~data) ? STATE_3 : STATE_0;
            STATE_3: next_state = (data) ? STATE_4 : STATE_0;
            STATE_4: begin
                next_state = STATE_0;
                start_shifting = 1'b1;
            end
            default: next_state = STATE_0;
        endcase
    end

endmodule
[DONE]