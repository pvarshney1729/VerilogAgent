module TopModule (
    input logic clk,         // Clock input, positive edge-triggered
    input logic areset,      // Asynchronous reset input, active high
    input logic x,           // Serial input bit stream, LSB first
    output logic z           // Output bit stream, representing 2's complement
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        NEGATE = 2'b01,
        OUTPUT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic carry, negate_bit;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == OUTPUT) begin
                z <= negate_bit;
            end
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = current_state;
        negate_bit = 1'b0;

        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = NEGATE;
                end
            end
            NEGATE: begin
                negate_bit = ~x ^ carry;
                carry = (~x & carry) | (x & ~carry);
                next_state = OUTPUT;
            end
            OUTPUT: begin
                next_state = NEGATE;
            end
        endcase
    end

endmodule