module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTDOWN,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [9:0] cycle_counter;
    logic [3:0] pattern_shift;
    logic [3:0] delay_shift;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'bxxxx;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_counter <= 10'b0;
            pattern_shift <= 4'b0;
            delay_shift <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                delay <= delay_shift;
                count <= delay_shift;
            end
            if (current_state == COUNTDOWN) begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'b0;
                    if (count != 4'b0) begin
                        count <= count - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                delay_shift = {delay_shift[2:0], data};
                if (delay_shift[3]) begin
                    next_state = COUNTDOWN;
                end
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (count == 4'b0 && cycle_counter == 10'd999) begin
                    next_state = WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = PATTERN_DETECT;
                end
            end
        endcase
    end

endmodule