module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input logic ack
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        DETECT_1101 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNTING = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [9:0] cycle_counter;
    logic [3:0] bit_counter;
    logic [3:0] delay_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            cycle_counter <= 10'd0;
            bit_counter <= 4'd0;
            delay <= 4'd0;
            delay_reg <= 4'd0;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                delay_reg <= {delay_reg[2:0], data};
                bit_counter <= bit_counter + 1;
            end else if (current_state == COUNTING) begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'd0;
                    if (delay > 0) begin
                        delay <= delay - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default values
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'bxxxx; // Don't care when not counting

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
                bit_counter = 4'd0;
            end
            LOAD_DELAY: begin
                if (bit_counter == 4'd3) begin
                    delay = delay_reg;
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                count = delay;
                if (delay == 0 && cycle_counter == 10'd999) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule