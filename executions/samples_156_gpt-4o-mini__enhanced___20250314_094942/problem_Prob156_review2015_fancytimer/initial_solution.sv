module TopModule (
    input  logic clk,            // Clock signal (positive edge triggered)
    input  logic reset,          // Active high synchronous reset
    input  logic data,           // Serial input data
    output logic [3:0] count,    // 4-bit output for current count value
    output logic counting,        // Indicates counting state (active high)
    output logic done,           // Indicates timer completion (active high)
    input  logic ack             // Acknowledgment input from user
);

    typedef enum logic [1:0] {
        IDLE,
        PATTERN_DETECT,
        SHIFT_DELAY,
        COUNTING,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [19:0] cycle_counter; // To count up to (delay + 1) * 1000
    logic [9:0] count_cycles;    // To count 1000 cycles for decrementing count

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_counter <= 20'b0;
            count_cycles <= 10'b0;
            delay <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == COUNTING) begin
                if (cycle_counter == 20'd999999) begin
                    cycle_counter <= 20'b0;
                    count_cycles <= count_cycles + 1'b1;
                end else begin
                    cycle_counter <= cycle_counter + 1'b1;
                end
            end
            if (current_state == DONE_STATE && ack) begin
                count <= 4'b0000;
                counting <= 1'b0;
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == COUNTING) begin
            if (count_cycles < (delay + 1'b1)) begin
                if (count_cycles % 10'd1000 == 0) begin
                    count <= delay - (count_cycles / 10'd1000);
                end
            end else begin
                next_state <= DONE_STATE;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (data == 1'b1) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (data == 1'b1) begin
                    next_state = SHIFT_DELAY;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT_DELAY: begin
                if (data == 1'b0) begin
                    delay[3] = data;
                    next_state = COUNTING;
                end else begin
                    delay = {delay[2:0], data};
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (count_cycles >= (delay + 1'b1)) begin
                    next_state = DONE_STATE;
                end
            end
            DONE_STATE: begin
                done = 1'b1;
                counting = 1'b0;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule