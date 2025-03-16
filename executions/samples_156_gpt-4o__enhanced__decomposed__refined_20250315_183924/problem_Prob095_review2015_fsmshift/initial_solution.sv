[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        ACTIVE = 2'b01
    } state_t;

    state_t state, next_state;
    logic [2:0] shift_count;
    logic reset_held;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 1'b1;
            shift_count <= 3'b000;
            reset_held <= 1'b1;
        end else begin
            state <= next_state;
            if (reset_held) begin
                if (shift_count < 3'd3) begin
                    shift_ena <= 1'b1;
                    shift_count <= shift_count + 1;
                end else begin
                    shift_ena <= 1'b0;
                    reset_held <= 1'b0;
                end
            end else if (state == ACTIVE) begin
                shift_ena <= 1'b1;
                shift_count <= shift_count + 1;
            end else begin
                shift_ena <= 1'b0;
                shift_count <= 3'b000;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                // Assume some pattern detection logic here
                // if (pattern_detected)
                //     next_state = ACTIVE;
            end
            ACTIVE: begin
                if (shift_count == 3'b100) // 4 clock cycles
                    next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]