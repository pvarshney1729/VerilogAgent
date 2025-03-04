module sequence_detector(
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        LOAD_DELAY = 2'b01,
        COUNTING = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [9:0] cycle_counter;
    logic [3:0] shift_reg;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'b0000;

        case (current_state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end

            LOAD_DELAY: begin
                if (bit_counter == 4) begin
                    next_state = COUNTING;
                end
            end

            COUNTING: begin
                counting = 1'b1;
                count = delay;
                if (cycle_counter == 0 && count == 0) begin
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

    // Shift register for sequence detection
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0000;
        end else if (current_state == IDLE) begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end

    // Delay capture and bit counter
    always_ff @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0000;
            bit_counter <= 4'b0000;
        end else if (current_state == LOAD_DELAY) begin
            delay <= {delay[2:0], data};
            bit_counter <= bit_counter + 1;
        end else begin
            bit_counter <= 4'b0000;
        end
    end

    // Cycle counter and count decrement
    always_ff @(posedge clk) begin
        if (reset) begin
            cycle_counter <= 10'b0;
        end else if (current_state == COUNTING) begin
            if (cycle_counter == 10'd999) begin
                cycle_counter <= 10'b0;
                if (count > 0) begin
                    count <= count - 1;
                end
            end else begin
                cycle_counter <= cycle_counter + 1;
            end
        end else begin
            cycle_counter <= 10'b0;
        end
    end

endmodule