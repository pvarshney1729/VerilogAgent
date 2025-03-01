module TopModule(
    input logic clk,          // Clock input, triggers sequential logic on rising edge
    input logic reset,        // Synchronous active high reset
    input logic data,         // Serial data input
    output logic [3:0] count, // 4-bit output, represents remaining time in 1000-cycle increments
    output logic counting,    // 1-bit output, asserted when counting
    output logic done,        // 1-bit output, asserted when counting is complete
    input logic ack           // 1-bit input, acknowledgment from user
);

    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [9:0] cycle_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'bxxxx;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_count <= 10'b0;
        end else begin
            state <= next_state;
            if (state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end
            if (state == COUNTING) begin
                if (cycle_count == 10'd999) begin
                    cycle_count <= 10'b0;
                    count <= count - 1;
                end else begin
                    cycle_count <= cycle_count + 1;
                end
            end
        end
    end

    always_comb begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
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
                if (data) next_state = LOAD_DELAY;
                else next_state = IDLE;
            end
            LOAD_DELAY: begin
                if (delay == 4'b1111) begin
                    next_state = COUNTING;
                    count = delay;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (count == 4'b0000 && cycle_count == 10'd999) begin
                    next_state = WAIT_ACK;
                    done = 1'b1;
                end
            end
            WAIT_ACK: begin
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule