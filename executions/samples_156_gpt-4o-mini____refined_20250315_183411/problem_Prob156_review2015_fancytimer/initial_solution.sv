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

    state_t state, next_state;
    logic [3:0] delay;
    logic [19:0] counter; // To count up to (delay + 1) * 1000
    logic [3:0] remaining_time;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 20'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == COUNTING) begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end else begin
                    counter <= 20'b0;
                end
            end else begin
                counter <= 20'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'b0;
        remaining_time = delay;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = SEARCH;
                end
            end

            SEARCH: begin
                if (data == 1'b1) begin
                    next_state = READ_DELAY;
                end
            end

            READ_DELAY: begin
                if (data == 1'b0) begin
                    delay[3] = 1'b1; // Assume we read 4 bits here
                end else if (data == 1'b1) begin
                    delay[2] = 1'b1; // Continue reading
                end else if (data == 1'b0) begin
                    delay[1] = 1'b1; // Continue reading
                end else if (data == 1'b1) begin
                    delay[0] = 1'b1; // Finish reading
                    next_state = COUNTING;
                end
            end

            COUNTING: begin
                counting = 1'b1;
                if (counter < (delay + 1) * 1000) begin
                    if (counter % 1000 == 0) begin
                        remaining_time = remaining_time - 1;
                    end
                end else begin
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