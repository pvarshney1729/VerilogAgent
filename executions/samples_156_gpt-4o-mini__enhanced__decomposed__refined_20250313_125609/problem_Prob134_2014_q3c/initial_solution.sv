[BEGIN]
module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    typedef enum logic [2:0] {
        STATE_000 = 3'b000,
        STATE_001 = 3'b001,
        STATE_010 = 3'b010,
        STATE_011 = 3'b011,
        STATE_100 = 3'b100
    } state_t;

    state_t current_state, next_state;

    always @(*) begin
        case (current_state)
            STATE_000: next_state = (x == 1'b0) ? STATE_000 : STATE_001;
            STATE_001: next_state = (x == 1'b0) ? STATE_001 : STATE_100;
            STATE_010: next_state = (x == 1'b0) ? STATE_010 : STATE_001;
            STATE_011: next_state = (x == 1'b0) ? STATE_001 : STATE_010;
            STATE_100: next_state = (x == 1'b0) ? STATE_011 : STATE_100;
            default: next_state = STATE_000; // Default case for safety
        endcase
    end

    always @(posedge clk) begin
        current_state <= next_state; // Update current state on clock edge
    end

    assign Y0 = next_state[0];
    assign z = (current_state == STATE_011) ? 1'b1 : 1'b0;

endmodule
[DONE]