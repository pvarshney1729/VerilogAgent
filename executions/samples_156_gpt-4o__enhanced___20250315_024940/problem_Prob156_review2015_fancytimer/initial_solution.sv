module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input  logic ack
);

    typedef enum logic [1:0] {
        IDLE,
        WAIT_PATTERN,
        READ_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [19:0] counter; // To count up to (delay + 1) * 1000
    logic [3:0] remaining_time;
    logic [3:0] bit_count;

    // Synchronous reset and state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counter <= 20'b0;
            bit_count <= 4'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;

            if (current_state == COUNTING) begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end else begin
                    counter <= 20'b0;
                end

                if (counter == (delay + 1) * 1000 - 1) begin
                    if (remaining_time > 0) begin
                        remaining_time <= remaining_time - 1;
                    end else begin
                        done <= 1'b1;
                        counting <= 1'b0;
                    end
                end
            end
        end
    end

    // Output logic
    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                counting <= 1'b0;
                done <= 1'b0;
                if (data == 1'b1) begin
                    next_state <= WAIT_PATTERN;
                    bit_count <= 4'b0;
                end else begin
                    next_state <= IDLE;
                end
            end

            WAIT_PATTERN: begin
                if (bit_count < 3) begin
                    if (data == (3 - bit_count)) begin
                        bit_count <= bit_count + 1;
                        next_state <= WAIT_PATTERN;
                    end else begin
                        next_state <= IDLE;
                    end
                end else begin
                    next_state <= READ_DELAY;
                end
            end

            READ_DELAY: begin
                if (bit_count < 7) begin
                    delay[3 - (bit_count - 4)] <= data; // Shift in the delay
                    bit_count <= bit_count + 1;
                    next_state <= READ_DELAY;
                end else begin
                    remaining_time <= delay;
                    counting <= 1'b1;
                    counter <= 20'b0;
                    next_state <= COUNTING;
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
                counting <= 1'b0;
                if (ack) begin
                    next_state <= IDLE;
                end else begin
                    next_state <= DONE;
                end
            end

            default: next_state <= IDLE;
        endcase
    end

    assign count = (counting) ? remaining_time : 4'bxxxx; // Don't care when not counting

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly