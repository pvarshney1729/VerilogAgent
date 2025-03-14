```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_FLIP = 2'b01,
        STATE_ADD  = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic flip_bit;
    logic add_carry;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_IDLE;
            flip_bit <= 1'b0;
            add_carry <= 1'b0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FLIP) begin
                flip_bit <= ~x;
            end
            if (current_state == STATE_ADD) begin
                {add_carry, z} <= flip_bit + 1'b1;
            end else begin
                z <= flip_bit;
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_IDLE: begin
                next_state = STATE_FLIP;
            end
            STATE_FLIP: begin
                next_state = STATE_ADD;
            end
            STATE_ADD: begin
                next_state = STATE_FLIP;
            end
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

endmodule
```