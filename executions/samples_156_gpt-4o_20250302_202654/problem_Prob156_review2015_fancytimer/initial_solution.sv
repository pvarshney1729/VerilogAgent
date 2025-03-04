module timer_fsm (
    input logic clk,
    input logic reset,
    input logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input logic ack
);

    typedef enum logic [2:0] {
        IDLE,
        DETECT,
        LOAD_DELAY,
        COUNT,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [13:0] cycle_counter;
    logic pattern_detected;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            bit_counter <= 4'b0000;
            cycle_counter <= 14'b0;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
                bit_counter <= bit_counter + 1;
            end
            if (current_state == COUNT) begin
                if (cycle_counter == 14'd999) begin
                    cycle_counter <= 14'b0;
                    count <= count - 1;
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
        pattern_detected = 1'b0;

        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = DETECT;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    pattern_detected = 1'b1;
                end
                if (pattern_detected) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                if (bit_counter == 4'b0100) begin
                    next_state = COUNT;
                    count = delay + 1;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (count == 4'b0000) begin
                    next_state = WAIT_ACK;
                    done = 1'b1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule