module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Active high synchronous reset
    input logic data,         // Serial data input
    input logic done_counting,// Indicates completion of counting
    input logic ack,          // Acknowledgment signal from the user
    output logic shift_ena,   // Enable signal for shifting, asserted for 4 cycles
    output logic counting,    // Indicates the module is waiting for counters
    output logic done         // Indicates the timer has completed
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNTING = 2'b10,
        DONE_STATE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_reg;
    logic [1:0] shift_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 4'b0000;
            shift_counter <= 2'b00;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_reg <= {shift_reg[2:0], data};
                shift_counter <= shift_counter + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                    shift_ena = 1'b1;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE_STATE;
                end
            end
            DONE_STATE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule