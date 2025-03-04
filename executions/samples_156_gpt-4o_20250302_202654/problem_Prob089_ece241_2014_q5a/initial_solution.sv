module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic carry;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_0;
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_1) begin
                z <= ~x ^ carry;
                carry <= carry | x;
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_0: begin
                next_state = STATE_1;
            end
            STATE_1: begin
                next_state = STATE_1;
            end
            default: begin
                next_state = STATE_0;
            end
        endcase
    end

endmodule