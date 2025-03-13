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
        SHIFT_DELAY,
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
                if (counter < (delay + 4'b1) * 10'd1000 - 1) begin
                    counter <= counter + 10'b1;
                end else begin
                    counter <= 10'b0;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (state == COUNTING) begin
            if (counter < 10'd1000) begin
                remaining_time <= delay;
            end else if (counter < 10'd2000) begin
                remaining_time <= delay - 4'b1;
            end else if (counter < 10'd3000) begin
                remaining_time <= delay - 4'b2;
            end else if (counter < 10'd4000) begin
                remaining_time <= delay - 4'b3;
            end else if (counter < 10'd5000) begin
                remaining_time <= delay - 4'b4;
            end else if (counter < 10'd6000) begin
                remaining_time <= delay - 4'b5;
            end else begin
                remaining_time <= 4'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        count = 4'b0; // Don't care when not counting
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN;
                end
            end
            WAIT_PATTERN: begin
                // Detect pattern 1101
                if (data == 1'b1) begin
                    next_state = SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                // Shift in 4 bits for delay
                delay = {delay[2:0], data};
                if (delay[3] == 1'b1) begin
                    next_state = COUNTING;
                    counting = 1'b1;
                end
            end
            COUNTING: begin
                if (counter >= (delay + 4'b1) * 10'd1000 - 1) begin
                    next_state = DONE_STATE;
                    done = 1'b1;
                end
            end
            DONE_STATE: begin
                if (ack == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule