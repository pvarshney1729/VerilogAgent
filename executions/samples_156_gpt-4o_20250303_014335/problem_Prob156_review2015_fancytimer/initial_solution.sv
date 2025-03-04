module TopModule (
    input  logic clk,          // Clock signal, positive edge triggered
    input  logic reset,        // Synchronous active-high reset
    input  logic data,         // Serial data input
    output logic [3:0] count,  // 4-bit output representing remaining time
    output logic counting,     // Indicates counting state
    output logic done,         // Indicates completion of the timer
    input  logic ack           // Acknowledge signal from the user
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        CAPTURE = 2'b01,
        COUNT = 2'b10,
        WAIT_ACK = 2'b11
    } state_t;

    state_t state, next_state;
    logic [3:0] shift_reg;
    logic [3:0] delay;
    logic [9:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            cycle_counter <= 10'b0000000000;
            count <= 4'bxxxx;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == IDLE) begin
                shift_reg <= {shift_reg[2:0], data};
            end else if (state == CAPTURE) begin
                delay <= {shift_reg[2:0], data};
            end else if (state == COUNT) begin
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
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = CAPTURE;
                end
            end
            CAPTURE: begin
                next_state = COUNT;
                count = delay;
            end
            COUNT: begin
                counting = 1'b1;
                if (count == 4'b0000 && cycle_counter == 10'd999) begin
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