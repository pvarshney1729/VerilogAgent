module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        SHIFT = 3'b010,
        COUNT = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;
    logic [3:0] pattern_shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 4'b0000;
            pattern_shift_reg <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 4'b0000;
            end
            pattern_shift_reg <= {pattern_shift_reg[2:0], data};
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = PATTERN_DETECTED;
                end
            end
            PATTERN_DETECTED: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_counter == 4'b0100) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done_counting) begin
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

    // Output logic
    always_comb begin
        shift_ena = (current_state == SHIFT);
        counting = (current_state == COUNT);
        done = (current_state == DONE);
    end

endmodule