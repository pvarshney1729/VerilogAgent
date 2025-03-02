module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        DETECT = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNT = 3'b011,
        WAIT_FOR_ACK = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_reg;
    logic [3:0] delay;
    logic [9:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            count <= 4'b0000;
            cycle_counter <= 10'b0000000000;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DETECT) begin
                shift_reg <= {shift_reg[2:0], data};
            end else if (current_state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
            end else if (current_state == COUNT) begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'b0000000000;
                    count <= count - 1;
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
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = DETECT;
                end
            end
            DETECT: begin
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                if (delay == 4'b1111) begin
                    next_state = COUNT;
                    count = delay;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (count == 4'b0000) begin
                    next_state = WAIT_FOR_ACK;
                    done = 1'b1;
                end
            end
            WAIT_FOR_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule