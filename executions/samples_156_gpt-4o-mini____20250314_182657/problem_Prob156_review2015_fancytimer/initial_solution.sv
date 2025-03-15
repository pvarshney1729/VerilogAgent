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
        DONE_STATE
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [9:0] counter; // 1000 cycles max
    logic [3:0] remaining_time;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 10'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == COUNTING) begin
                if (counter < 10'd999) begin
                    counter <= counter + 10'b1;
                end else begin
                    counter <= 10'b0;
                    if (remaining_time > 4'b0) begin
                        remaining_time <= remaining_time - 4'b1;
                    end
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            remaining_time <= 4'b0;
        end else if (state == READ_DELAY) begin
            remaining_time <= delay;
        end
    end

    always_comb begin
        next_state = state;
        count = 4'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = SEARCH;
                end
            end

            SEARCH: begin
                if (data == 1'b1) begin
                    next_state = READ_DELAY;
                end else if (data == 1'b0) begin
                    next_state = IDLE;
                end
            end

            READ_DELAY: begin
                delay = {data, delay[3:1]}; // Shift in the next bit
                if (delay[3] == 1'b1 && delay[2] == 1'b1 && delay[1] == 1'b0 && delay[0] == 1'b1) begin
                    next_state = COUNTING;
                    counting = 1'b1;
                end
            end

            COUNTING: begin
                if (remaining_time == 4'b0) begin
                    next_state = DONE_STATE;
                end
                count = remaining_time;
            end

            DONE_STATE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule