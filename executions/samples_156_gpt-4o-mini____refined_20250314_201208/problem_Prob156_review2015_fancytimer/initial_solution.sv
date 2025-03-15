module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input  logic ack
);

    typedef enum logic [2:0] {
        IDLE,
        SEARCH,
        READ_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [9:0] counter; // 1000 cycles max
    logic [3:0] remaining_time;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counter <= 10'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == COUNTING) begin
                if (counter < 10'd999) begin
                    counter <= counter + 10'b1;
                end else begin
                    counter <= 10'b0;
                    if (remaining_time > 4'b0) begin
                        remaining_time <= remaining_time - 4'b1;
                    end else begin
                        done <= 1'b1;
                    end
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0;
            counting <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    if (data == 1'b1) begin
                        next_state <= SEARCH;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                SEARCH: begin
                    if (data == 1'b1) begin
                        next_state <= READ_DELAY;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                READ_DELAY: begin
                    delay <= {delay[2:0], data}; // Shift in the next bit
                    if (delay[3] == 1'b1) begin
                        next_state <= COUNTING;
                        remaining_time <= delay;
                        counting <= 1'b1;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                COUNTING: begin
                    if (done) begin
                        next_state <= DONE;
                    end else begin
                        next_state <= COUNTING;
                    end
                end
                DONE: begin
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

    assign count = (counting) ? remaining_time : 4'bxxxx;

endmodule