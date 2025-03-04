module TopModule(
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
        PATTERN_DETECT = 2'b01,
        COUNTING = 2'b10,
        COMPLETION = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_reg;
    logic [3:0] delay;
    logic [13:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            cycle_counter <= 14'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PATTERN_DETECT) begin
                shift_reg <= {shift_reg[2:0], data};
            end
            if (current_state == COUNTING) begin
                cycle_counter <= cycle_counter + 1;
                count <= cycle_counter[13:10];
            end
        end
    end

    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = PATTERN_DETECT;
                end
            end
            PATTERN_DETECT: begin
                if (shift_reg == 4'b1101) begin
                    delay = {shift_reg[2:0], data};
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (cycle_counter == ((delay + 1) * 1000) - 1) begin
                    next_state = COMPLETION;
                end
            end
            COMPLETION: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule