module TopModule (
    input logic clk,
    input logic reset,
    input logic ack,
    input logic [3:0] data_in,
    output logic done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        DETECT = 2'b01,
        COUNT = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay_counter;
    logic [3:0] pattern_shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            delay_counter <= 4'b0000;
            pattern_shift_reg <= 4'b0000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DETECT) begin
                delay_counter <= data_in;
            end else if (current_state == COUNT) begin
                delay_counter <= delay_counter - 1;
            end
            if (current_state == DONE) begin
                done <= 1'b1;
            end else if (ack) begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = DETECT;
                end
            end
            DETECT: begin
                next_state = COUNT;
            end
            COUNT: begin
                if (delay_counter == 4'b0000) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Pattern detection logic
    always_ff @(posedge clk) begin
        if (reset) begin
            pattern_shift_reg <= 4'b0000;
        end else begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], data_in[0]};
        end
    end

endmodule