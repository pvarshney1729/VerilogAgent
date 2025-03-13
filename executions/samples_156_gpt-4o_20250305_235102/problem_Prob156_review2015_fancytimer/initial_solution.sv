module TopModule (
    input logic clk,          // Positive edge-triggered clock signal
    input logic reset,        // Active high synchronous reset
    input logic data,         // Serial data input
    input logic ack,          // Acknowledge signal, active high
    output logic [3:0] count, // 4-bit counter
    output logic counting,    // Indicates active counting
    output logic done         // Indicates countdown completion
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNT = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [12:0] cycle_counter; // To count up to 1000 cycles

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            bit_counter <= 4'b0;
            cycle_counter <= 13'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        counting = 1'b0;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    bit_counter = bit_counter + 1;
                    if (bit_counter == 4) begin
                        next_state = SHIFT;
                        bit_counter = 0;
                    end
                end else begin
                    bit_counter = 0;
                end
            end
            SHIFT: begin
                delay[3:0] = {delay[2:0], data};
                bit_counter = bit_counter + 1;
                if (bit_counter == 4) begin
                    next_state = COUNT;
                    bit_counter = 0;
                    cycle_counter = 0;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (cycle_counter == 1000) begin
                    cycle_counter = 0;
                    count = count - 1;
                    if (count == 0) begin
                        next_state = DONE;
                    end
                end else begin
                    cycle_counter = cycle_counter + 1;
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

endmodule