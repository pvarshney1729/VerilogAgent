```verilog
module TopModule (
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

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [9:0] cycle_counter;
    logic [3:0] remaining_time;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            delay <= 4'b0;
            bit_counter <= 4'b0;
            cycle_counter <= 10'b0;
            remaining_time <= 4'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and outputs
    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'bxxxx; // Don't care when not counting

        case (current_state)
            IDLE: begin
                if (data == 1'b1 && bit_counter == 4'b0000) begin
                    bit_counter = bit_counter + 1;
                end else if (data == 1'b1 && bit_counter == 4'b0001) begin
                    bit_counter = bit_counter + 1;
                end else if (data == 1'b0 && bit_counter == 4'b0010) begin
                    bit_counter = bit_counter + 1;
                end else if (data == 1'b1 && bit_counter == 4'b0011) begin
                    next_state = LOAD_DELAY;
                    bit_counter = 4'b0000;
                end else begin
                    bit_counter = 4'b0000;
                end
            end

            LOAD_DELAY: begin
                if (bit_counter < 4) begin
                    delay[3 - bit_counter] = data;
                    bit_counter = bit_counter + 1;
                end else begin
                    next_state = COUNTING;
                    cycle_counter = 10'b0;
                    remaining_time = delay;
                end
            end

            COUNTING: begin
                counting = 1'b1;
                if (cycle_counter < 10'd999) begin
                    cycle_counter = cycle_counter + 1;
                end else begin
                    cycle_counter = 10'b0;
                    if (remaining_time > 0) begin
                        remaining_time = remaining_time - 1;
                    end else begin
                        next_state = DONE;
                    end
                end
                count = remaining_time;
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
```