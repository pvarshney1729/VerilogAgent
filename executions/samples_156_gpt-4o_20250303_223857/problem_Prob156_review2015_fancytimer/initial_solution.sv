module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic [3:0] count,
    output logic counting,
    output logic done,
    input logic ack
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNT = 2'b10,
        WAIT_ACK = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [12:0] cycle_counter;
    logic [3:0] pattern_shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            bit_counter <= 4'b0;
            cycle_counter <= 13'b0;
            pattern_shift_reg <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end
            if (current_state == COUNT) begin
                cycle_counter <= cycle_counter + 1;
                if (cycle_counter == 13'd999) begin
                    cycle_counter <= 13'b0;
                    count <= count - 1;
                end
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                    bit_counter = 4'b0;
                end
            end
            SHIFT: begin
                if (bit_counter < 4) begin
                    bit_counter = bit_counter + 1;
                    delay[3 - bit_counter] = data;
                end else begin
                    next_state = COUNT;
                    count = delay + 1;
                    counting = 1'b1;
                end
            end
            COUNT: begin
                if (count == 0) begin
                    next_state = WAIT_ACK;
                    done = 1'b1;
                    counting = 1'b0;
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