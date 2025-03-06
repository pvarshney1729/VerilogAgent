module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        PATTERN_DETECT = 2'b01,
        COUNTING = 2'b10,
        COMPLETION = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [13:0] cycle_counter;
    logic [3:0] pattern_shift_reg;
    logic [3:0] delay_shift_reg;
    logic pattern_detected;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'bxxxx;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_counter <= 14'b0;
            pattern_shift_reg <= 4'b0;
            delay_shift_reg <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PATTERN_DETECT) begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            if (current_state == COUNTING) begin
                cycle_counter <= cycle_counter - 1;
                if (cycle_counter == 0) begin
                    count <= count - 1;
                    cycle_counter <= 1000;
                end
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        pattern_detected = (pattern_shift_reg == 4'b1101);
        case (current_state)
            IDLE: begin
                counting = 1'b0;
                done = 1'b0;
                if (pattern_detected) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (pattern_detected) begin
                    delay_shift_reg = {delay_shift_reg[2:0], data};
                    if (&delay_shift_reg) begin
                        delay = delay_shift_reg;
                        count = delay + 1;
                        cycle_counter = 1000;
                        next_state = COUNTING;
                    end
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (count == 0) begin
                    next_state = COMPLETION;
                end
            end
            COMPLETION: begin
                counting = 1'b0;
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule