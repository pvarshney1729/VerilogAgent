module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input logic ack
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [3:0] pattern_shift;
    logic [3:0] delay_shift;
    logic [13:0] cycle_counter;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern_shift <= 4'b0000;
            delay_shift <= 4'b0000;
            cycle_counter <= 14'b0;
            delay <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == IDLE) begin
                pattern_shift <= {pattern_shift[2:0], data};
            end else if (state == PATTERN_DETECT) begin
                delay_shift <= {delay_shift[2:0], data};
            end else if (state == LOAD_DELAY) begin
                delay <= delay_shift;
            end else if (state == COUNTING) begin
                if (cycle_counter != 14'b0) begin
                    cycle_counter <= cycle_counter - 1;
                end
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'bxxxx; // Don't care when not counting

        case (state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (delay_shift == 4'b1111) begin // After 4 shifts
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                cycle_counter = (delay + 1) * 1000;
                next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                count = cycle_counter[13:10]; // Remaining time in terms of 1000 cycles
                if (cycle_counter == 14'b0) begin
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