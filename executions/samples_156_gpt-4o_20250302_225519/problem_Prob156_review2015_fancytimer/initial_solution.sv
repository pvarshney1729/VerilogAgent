module TopModule(
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
        LOAD_DELAY = 2'b01,
        COUNT = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [12:0] cycle_counter;
    logic [3:0] shift_register;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            bit_counter <= 4'b0;
            cycle_counter <= 13'b0;
            shift_register <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == LOAD_DELAY) begin
                shift_register <= {shift_register[2:0], data};
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
                counting = 1'b0;
                done = 1'b0;
                if (shift_register == 4'b1101) begin
                    next_state = LOAD_DELAY;
                    bit_counter = 4'b0;
                end
            end
            LOAD_DELAY: begin
                if (bit_counter < 4) begin
                    bit_counter = bit_counter + 1;
                end else begin
                    delay = shift_register;
                    count = shift_register;
                    next_state = COUNT;
                    counting = 1'b1;
                end
            end
            COUNT: begin
                if (count == 4'b0) begin
                    next_state = DONE;
                    counting = 1'b0;
                    done = 1'b1;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule