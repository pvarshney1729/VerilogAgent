module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_count;
    logic [9:0] cycle_count;
    logic [3:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            bit_count <= 4'b0;
            cycle_count <= 10'b0;
            shift_reg <= 4'b0;
        end else begin
            state <= next_state;
            if (state == LOAD_DELAY) begin
                shift_reg <= {shift_reg[2:0], data};
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
                if (data == 1'b1) begin
                    shift_reg = {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101) begin
                        next_state = LOAD_DELAY;
                        bit_count = 4'b0;
                    end
                end
            end
            LOAD_DELAY: begin
                if (bit_count < 4) begin
                    bit_count = bit_count + 1;
                end else begin
                    delay = shift_reg;
                    count = shift_reg;
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (count == 4'b0 && cycle_count == 10'd999) begin
                    next_state = WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule