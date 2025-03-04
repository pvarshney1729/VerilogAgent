module TopModule(
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
        COUNT = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] pattern_shift;
    logic [15:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            pattern_shift <= 4'b0000;
            delay <= 4'b0000;
            cycle_counter <= 16'b0;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end
            if (current_state == COUNT) begin
                if (cycle_counter == 16'd0) begin
                    count <= count - 1;
                    cycle_counter <= 16'd999;
                end else begin
                    cycle_counter <= cycle_counter - 1;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == IDLE) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end
    end

    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                if (delay == 4'b1111) begin
                    next_state = COUNT;
                    count = delay + 1;
                    cycle_counter = 16'd999;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (count == 4'b0000 && cycle_counter == 16'd0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule