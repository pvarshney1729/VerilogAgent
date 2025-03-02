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
        DETECT,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [9:0] counter; // 1000 cycles max
    logic [3:0] remaining_time;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 10'b0;
            delay <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == COUNT) begin
                if (counter < (delay + 4'b1) * 10'd100) begin
                    counter <= counter + 10'b1;
                end else begin
                    counter <= 10'b0;
                end
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
                    next_state = DETECT;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                delay = {delay[2:0], data};
                if (delay[3] == 1'b1) begin
                    next_state = COUNT;
                    counting = 1'b1;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (counter == (delay + 4'b1) * 10'd100) begin
                    next_state = DONE;
                end
                count = remaining_time;
                if (counter % 10'd100 == 0 && remaining_time > 4'b0) begin
                    remaining_time = remaining_time - 4'b1;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                    delay = 4'b0;
                end
            end
        endcase
    end

endmodule