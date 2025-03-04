module TopModule (
    input logic clk,      // Clock signal, positive-edge triggered
    input logic areset,   // Asynchronous reset signal, active high
    input logic x,        // Input data bit (LSB first)
    output logic z        // Output data bit (2's complement of input)
);

    typedef enum logic {PASS_THROUGH, COMPLEMENT} state_t;
    state_t state, next_state;
    logic carry;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= PASS_THROUGH;
            z <= 1'b0;
            carry <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (state == PASS_THROUGH) begin
            z <= ~x; // Invert input
            if (x == 1'b1) begin
                next_state <= COMPLEMENT; // Transition to COMPLEMENT state
            end else begin
                next_state <= PASS_THROUGH; // Stay in PASS_THROUGH
            end
        end else if (state == COMPLEMENT) begin
            z <= ~x ^ carry; // Invert input and add carry
            carry <= (x == 1'b1) ? 1'b1 : carry; // Set carry if x is 1
            next_state <= COMPLEMENT; // Stay in COMPLEMENT
        end
    end

endmodule