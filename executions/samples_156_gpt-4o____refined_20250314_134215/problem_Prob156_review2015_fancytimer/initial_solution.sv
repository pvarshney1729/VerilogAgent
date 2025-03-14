[BEGIN]
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
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNTING = 3'b110,
        WAIT_ACK = 3'b111
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay, delay_counter;
    logic [9:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            delay <= 4'b0000;
            delay_counter <= 4'b0000;
            cycle_counter <= 10'b0000000000;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end
            if (current_state == COUNTING) begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'b0000000000;
                    if (delay_counter != 4'b0000) begin
                        delay_counter <= delay_counter - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'bxxxx;

        case (current_state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end
            DETECT_11: begin
                if (!data) next_state = DETECT_110;
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (data) next_state = DETECT_1101;
                else next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = LOAD_DELAY;
            end
            LOAD_DELAY: begin
                if (delay == 4'b1111) begin
                    next_state = COUNTING;
                    delay_counter = delay;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                count = delay_counter;
                if (delay_counter == 4'b0000 && cycle_counter == 10'd999) begin
                    next_state = WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]