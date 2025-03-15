module TopModule(
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
        CAPTURE_DELAY,
        COUNTDOWN,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay, delay_counter;
    logic [9:0] cycle_counter; // To count up to 1000 cycles

    // Sequential logic for state transitions and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            delay <= 4'b0;
            delay_counter <= 4'b0;
            cycle_counter <= 10'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;

            case (current_state)
                PATTERN_DETECT: begin
                    // Shift in the delay value once the pattern is detected
                    delay <= {delay[2:0], data};
                end
                CAPTURE_DELAY: begin
                    delay_counter <= delay;
                    cycle_counter <= 10'b0;
                end
                COUNTDOWN: begin
                    if (cycle_counter == 10'd999) begin
                        cycle_counter <= 10'b0;
                        if (delay_counter != 4'b0) begin
                            delay_counter <= delay_counter - 1;
                        end
                    end else begin
                        cycle_counter <= cycle_counter + 1;
                    end
                    count <= delay_counter;
                end
                WAIT_ACK: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

    // Combinational logic for next state logic
    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (&{delay[2:0], data}) begin // Pattern 1101 detected
                    next_state = CAPTURE_DELAY;
                end
            end
            CAPTURE_DELAY: begin
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (delay_counter == 4'b0 && cycle_counter == 10'd999) begin
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