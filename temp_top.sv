```verilog
[BEGIN]
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
        DETECT = 2'b01,
        COUNT = 2'b10,
        WAIT_ACK = 2'b11
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [9:0] cycle_counter;
    logic [3:0] pattern_shift;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0000; // Changed to 4'b0000 on reset
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            bit_counter <= 4'b0000;
            cycle_counter <= 10'b0000000000;
            pattern_shift <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == DETECT) begin
                pattern_shift <= {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    bit_counter <= 4'b0000;
                end else if (bit_counter < 4'b0100) begin
                    delay <= {delay[2:0], data};
                    bit_counter <= bit_counter + 1;
                end
            end else if (state == COUNT) begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'b0000000000;
                    if (count > 4'b0000) begin // Ensure count does not underflow
                        count <= count - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = DETECT;
                end
            end
            DETECT: begin
                if (bit_counter == 4'b0100) begin
                    next_state = COUNT;
                    count = delay; // Timing for counting
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (count == 4'b0000 && cycle_counter == 10'd999) begin
                    next_state = WAIT_ACK;
                    done = 1'b1;
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
[DONE]
```