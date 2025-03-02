module pattern_detector (
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        Idle = 2'b00,
        Shift = 2'b01,
        Counting = 2'b10,
        Done = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift_reg;
    logic [1:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= Idle;
            pattern_shift_reg <= 4'b0000;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == Idle) begin
                pattern_shift_reg <= {pattern_shift_reg[2:0], data};
            end else if (current_state == Shift) begin
                shift_counter <= shift_counter + 1;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            Idle: begin
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = Shift;
                end
            end
            Shift: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = Counting;
                end
            end
            Counting: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = Done;
                end
            end
            Done: begin
                done = 1'b1;
                if (ack) begin
                    next_state = Idle;
                end
            end
        endcase
    end

endmodule