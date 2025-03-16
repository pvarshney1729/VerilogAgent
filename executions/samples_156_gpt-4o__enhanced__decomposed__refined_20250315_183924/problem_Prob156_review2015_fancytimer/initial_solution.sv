module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECT = 3'b001,
        DELAY_CAPTURE = 3'b010,
        COUNTING = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay, next_delay;
    logic [9:0] cycle_count, next_cycle_count;
    logic [3:0] shift_reg;
    logic [2:0] pattern_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            delay <= 4'b0000;
            cycle_count <= 10'b0000000000;
            count <= 4'bxxxx;
            counting <= 0;
            done <= 0;
            pattern_count <= 0;
            shift_reg <= 4'b0000;
        end else begin
            current_state <= next_state;
            delay <= next_delay;
            cycle_count <= next_cycle_count;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        next_delay = delay;
        next_cycle_count = cycle_count;
        count = 4'bxxxx;
        counting = 0;
        done = 0;

        case (current_state)
            IDLE: begin
                if (data && pattern_count == 0) pattern_count = 1;
                else if (!data && pattern_count == 1) pattern_count = 2;
                else if (data && pattern_count == 2) pattern_count = 3;
                else if (!data && pattern_count == 3) begin
                    next_state = PATTERN_DETECT;
                    pattern_count = 0;
                end
            end

            PATTERN_DETECT: begin
                next_state = DELAY_CAPTURE;
            end

            DELAY_CAPTURE: begin
                shift_reg = {shift_reg[2:0], data};
                if (pattern_count == 3) begin
                    next_delay = {shift_reg[2:0], data};
                    next_state = COUNTING;
                    pattern_count = 0;
                end else begin
                    pattern_count = pattern_count + 1;
                end
            end

            COUNTING: begin
                counting = 1;
                if (cycle_count < 1000) begin
                    next_cycle_count = cycle_count + 1;
                end else if (delay > 0) begin
                    next_cycle_count = 0;
                    next_delay = delay - 1;
                end else begin
                    next_state = WAIT_ACK;
                end
                count = delay;
            end

            WAIT_ACK: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule