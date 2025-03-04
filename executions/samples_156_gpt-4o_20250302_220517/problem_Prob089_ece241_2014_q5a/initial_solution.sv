module TopModule (
    input logic clk,        // Clock signal, positive edge triggered
    input logic areset,     // Asynchronous reset, active high
    input logic x,          // Serial input bit stream
    output logic z          // Serial output bit stream
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FLIP = 2'b01,
        ADD_ONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic carry;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            carry <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == ADD_ONE) begin
                carry <= carry & x;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        z = 1'b0;
        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = FLIP;
                end
            end
            FLIP: begin
                z = ~x;
                next_state = ADD_ONE;
            end
            ADD_ONE: begin
                z = x ^ carry;
                carry = x & carry;
                next_state = ADD_ONE;
            end
        endcase
    end

endmodule