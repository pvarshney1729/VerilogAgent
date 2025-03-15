module TopModule(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COMPLEMENT = 2'b01
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
            if (current_state == IDLE) begin
                carry <= 1'b1; // Initialize carry for 2's complement
            end else if (current_state == COMPLEMENT) begin
                carry <= carry & x; // Update carry based on input
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = COMPLEMENT;
                end else begin
                    next_state = IDLE;
                end
            end
            COMPLEMENT: begin
                next_state = COMPLEMENT; // Remain in COMPLEMENT state
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        if (current_state == COMPLEMENT) begin
            z = ~x ^ carry; // 2's complement logic
        end else begin
            z = 1'b0;
        end
    end

endmodule