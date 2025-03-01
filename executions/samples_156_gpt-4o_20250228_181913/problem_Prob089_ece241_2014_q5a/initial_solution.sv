module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FLIP = 2'b01,
        ADD_ONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic carry;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            carry <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state; // Default to hold state
        z = 1'b0; // Default output

        case (current_state)
            IDLE: begin
                if (x) begin
                    next_state = FLIP;
                    z = 1'b0;
                end else begin
                    next_state = FLIP;
                    z = 1'b1;
                end
            end

            FLIP: begin
                if (x) begin
                    z = ~x;
                    next_state = ADD_ONE;
                end else begin
                    z = ~x;
                    next_state = FLIP;
                end
            end

            ADD_ONE: begin
                z = x ^ carry;
                carry = x & carry;
                next_state = FLIP;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule