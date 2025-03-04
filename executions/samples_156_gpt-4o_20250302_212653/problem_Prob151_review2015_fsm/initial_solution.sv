module fsm_pattern_detector (
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNT = 2'b10,
        NOTIFY = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_counter;
    logic [3:0] pattern_shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 2'b00;
            pattern_shift_reg <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 2'b00;

            if (current_state == IDLE)
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101)
                    next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = NOTIFY;
            end
            NOTIFY: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule