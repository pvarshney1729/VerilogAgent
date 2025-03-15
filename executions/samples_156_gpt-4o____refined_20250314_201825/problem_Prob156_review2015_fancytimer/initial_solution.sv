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
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [13:0] cycle_counter;

    // State Transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (bit_counter == 4 && data == 1'b1) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                if (bit_counter == 4) begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (cycle_counter == 14'd0) begin
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

    // Output Logic and Counters
    always_ff @(posedge clk) begin
        if (reset) begin
            bit_counter <= 4'd0;
            cycle_counter <= 14'd0;
            delay <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
        end else begin
            case (current_state)
                IDLE: begin
                    bit_counter <= 4'd0;
                    cycle_counter <= 14'd0;
                    delay <= 4'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN_DETECT: begin
                    bit_counter <= bit_counter + 1;
                end
                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                    bit_counter <= bit_counter + 1;
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (cycle_counter == 14'd0) begin
                        if (delay != 4'd0) begin
                            delay <= delay - 1;
                            cycle_counter <= 14'd999;
                        end else begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end
                    end else begin
                        cycle_counter <= cycle_counter - 1;
                    end
                    count <= delay;
                end
                WAIT_ACK: begin
                    done <= 1'b1;
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
```