module TopModule(
    input logic clk,               // Clock signal
    input logic reset,             // Active high synchronous reset
    input logic data,              // Serial data input
    output logic [3:0] count,      // 4-bit output indicating remaining time
    output logic counting,         // Indicates active counting
    output logic done,             // Indicates timer completion
    input logic ack                // Acknowledge signal from the user
);

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        DELAY_CAPTURE,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [13:0] cycle_counter; // To count up to 16000 cycles (14 bits)

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_counter <= 14'b0;
            delay <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == COUNTING) begin
                if (cycle_counter == 14'd999) begin
                    cycle_counter <= 14'b0;
                    if (count > 0) begin
                        count <= count - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (data == 1'b1) begin
                    next_state = DELAY_CAPTURE;
                end else begin
                    next_state = IDLE;
                end
            end
            DELAY_CAPTURE: begin
                delay = {delay[2:0], data};
                if (&delay) begin // After capturing 4 bits
                    count = delay;
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (count == 0 && cycle_counter == 14'd999) begin
                    done = 1'b1;
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

endmodule