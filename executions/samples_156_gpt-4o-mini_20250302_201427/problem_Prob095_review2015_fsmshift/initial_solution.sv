module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE,
        DETECT,
        SHIFT_ENABLE,
        WAIT
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 1'b1;
            shift_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT_ENABLE) begin
                if (shift_counter < 3'b011) begin
                    shift_counter <= shift_counter + 1;
                    shift_ena <= 1'b1;
                end else begin
                    shift_ena <= 1'b0;
                    shift_counter <= 3'b000;
                end
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (/* condition for pattern detection */) begin
                    next_state = DETECT;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT: begin
                next_state = SHIFT_ENABLE;
            end
            SHIFT_ENABLE: begin
                if (shift_counter == 3'b011) begin
                    next_state = WAIT;
                end else begin
                    next_state = SHIFT_ENABLE;
                end
            end
            WAIT: begin
                if (/* condition for pattern detection */) begin
                    next_state = DETECT;
                end else begin
                    next_state = WAIT;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule