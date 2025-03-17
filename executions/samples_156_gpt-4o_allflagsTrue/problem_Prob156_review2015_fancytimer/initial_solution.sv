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
        WAIT_ACK = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [13:0] cycle_counter;
    logic [3:0] pattern_shift_reg;
    logic [3:0] delay_shift_reg;
    logic [2:0] bit_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'bxxxx; // Don't-care when not counting

        case (current_state)
            IDLE: begin
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                    bit_counter = 3'b100;
                end
            end

            LOAD_DELAY: begin
                if (bit_counter > 0) begin
                    delay_shift_reg = {delay_shift_reg[2:0], data};
                    bit_counter = bit_counter - 1;
                end else begin
                    delay = delay_shift_reg;
                    next_state = COUNTING;
                    cycle_counter = (delay + 1) * 1000;
                end
            end

            COUNTING: begin
                counting = 1'b1;
                count = cycle_counter[13:10];
                if (cycle_counter == 0) begin
                    next_state = WAIT_ACK;
                end else begin
                    cycle_counter = cycle_counter - 1;
                end
            end

            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule