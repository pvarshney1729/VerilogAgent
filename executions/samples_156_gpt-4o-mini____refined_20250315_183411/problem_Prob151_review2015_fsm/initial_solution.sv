[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    input  logic done_counting,
    input  logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        WAIT_PATTERN,
        SHIFT,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1'b1;
            end else if (next_state == IDLE) begin
                shift_counter <= 4'b0000;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            next_state <= IDLE;
        end else begin
            case (current_state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data == 1'b1) begin
                        next_state <= WAIT_PATTERN;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                WAIT_PATTERN: begin
                    if (data == 1'b1) begin
                        next_state <= WAIT_PATTERN;
                    end else if (data == 1'b0) begin
                        next_state <= IDLE;
                    end else begin
                        next_state <= SHIFT;
                    end
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    if (shift_counter == 4'b0011) begin
                        next_state <= COUNTING;
                    end else begin
                        next_state <= SHIFT;
                    end
                end
                COUNTING: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    if (done_counting) begin
                        next_state <= DONE;
                    end else begin
                        next_state <= COUNTING;
                    end
                end
                DONE: begin
                    done <= 1'b1;
                    if (ack) begin
                        next_state <= IDLE;
                    end else begin
                        next_state <= DONE;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule
```
[DONE]