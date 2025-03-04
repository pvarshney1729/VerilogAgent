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
        LOAD_DELAY = 2'b01,
        COUNTING = 2'b10,
        WAIT_ACK = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [9:0] cycle_counter;
    logic [3:0] pattern_shift_reg;
    logic [3:0] delay_shift_reg;
    logic pattern_detected;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_counter <= 10'b0;
            pattern_shift_reg <= 4'b0000;
            delay_shift_reg <= 4'b0000;
            delay <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                delay_shift_reg <= {delay_shift_reg[2:0], data};
            end
            if (current_state == COUNTING) begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'b0;
                    if (count > 0) begin
                        count <= count - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            pattern_shift_reg <= 4'b0000;
            pattern_detected <= 1'b0;
        end else if (current_state == IDLE) begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            if (pattern_shift_reg == 4'b1101) begin
                pattern_detected <= 1'b1;
            end else begin
                pattern_detected <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (pattern_detected) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                if (&delay_shift_reg) begin
                    delay = delay_shift_reg;
                    count = delay;
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (count == 0 && cycle_counter == 10'd999) begin
                    done = 1'b1;
                    next_state = WAIT_ACK;
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