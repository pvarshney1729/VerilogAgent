```verilog
[BEGIN]
module TopModule (
    input logic clk,                  // Clock input, positive edge-triggered
    input logic reset,                // Active-high synchronous reset
    input logic data,                 // Serial data input
    output logic [3:0] count,         // 4-bit output representing current count value
    output logic counting,            // Output asserted when timer is counting
    output logic done,                // Output asserted when counting is complete
    input logic ack                   // Acknowledge input from the user
);

    // State machine states
    typedef enum logic [2:0] {
        IDLE,
        DETECT_1101,
        SHIFT_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [9:0] cycle_counter;
    logic [3:0] bit_counter;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            cycle_counter <= 10'b0;
            bit_counter <= 4'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                count = 4'bxxxx; // Don't care
                counting = 1'b0;
                done = 1'b0;
                if (data == 1'b1) begin
                    next_state = DETECT_1101;
                end
            end
            DETECT_1101: begin
                if (data == 1'b0) begin
                    next_state = SHIFT_DELAY;
                end
            end
            SHIFT_DELAY: begin
                if (bit_counter < 4) begin
                    next_state = SHIFT_DELAY;
                end else begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (cycle_counter == 10'd999) begin
                    if (count == 4'b0000) begin
                        next_state = WAIT_ACK;
                    end else begin
                        next_state = COUNTING;
                    end
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

    always @(posedge clk) begin
        if (current_state == SHIFT_DELAY) begin
            delay <= {delay[2:0], data};
            bit_counter <= bit_counter + 1;
        end else if (current_state == IDLE) begin
            bit_counter <= 4'b0;
        end
    end

    always @(posedge clk) begin
        if (current_state == COUNTING) begin
            if (cycle_counter == 10'd999) begin
                cycle_counter <= 10'b0;
                if (count > 4'b0000) begin
                    count <= count - 1;
                end
            end else begin
                cycle_counter <= cycle_counter + 1;
            end
        end else begin
            cycle_counter <= 10'b0;
        end
    end
endmodule
[DONE]
```