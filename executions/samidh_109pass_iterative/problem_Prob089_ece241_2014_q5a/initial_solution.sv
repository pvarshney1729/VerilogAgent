module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        PROCESS = 2'b01,
        COMPLEMENT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic complement_bit;
    logic found_one;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            found_one <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PROCESS && x == 1'b1) begin
                found_one <= 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = PROCESS;
                end else begin
                    next_state = IDLE;
                end
            end
            PROCESS: begin
                if (found_one) begin
                    next_state = COMPLEMENT;
                end else begin
                    next_state = PROCESS;
                end
            end
            COMPLEMENT: begin
                next_state = COMPLEMENT;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            IDLE: z = 1'b0;
            PROCESS: z = found_one ? ~x : x;
            COMPLEMENT: z = ~x;
            default: z = 1'b0;
        endcase
    end

endmodule