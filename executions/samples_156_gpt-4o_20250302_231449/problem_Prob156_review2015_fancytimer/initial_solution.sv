```verilog
module pattern_timer (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [9:0] cycle_counter;
    logic [3:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            bit_counter <= 4'b0000;
            cycle_counter <= 10'b0000000000;
            shift_reg <= 4'b0000;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    count <= 4'b0000;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data) begin
                        shift_reg <= {shift_reg[2:0], data};
                        if (shift_reg == 4'b110) begin
                            next_state <= PATTERN_DETECT;
                        end
                    end
                end
                PATTERN_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        next_state <= LOAD_DELAY;
                        bit_counter <= 4'b0000;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                    bit_counter <= bit_counter + 1;
                    if (bit_counter == 4'b0011) begin
                        next_state <= COUNTING;
                        count <= delay;
                        counting <= 1'b1;
                        cycle_counter <= 10'b0000000000;
                    end
                end
                COUNTING: begin
                    if (cycle_counter == 10'd999) begin
                        cycle_counter <= 10'b0000000000;
                        if (count == 4'b0000) begin
                            next_state <= WAIT_ACK;
                            counting <= 1'b0;
                            done <= 1'b1;
                        end else begin
                            count <= count - 1;
                        end
                    end else begin
                        cycle_counter <= cycle_counter + 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        next_state <= IDLE;
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state;
    end

endmodule
```