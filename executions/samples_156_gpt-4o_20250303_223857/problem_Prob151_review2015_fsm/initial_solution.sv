module TopModule (
    input  logic clk,            // Clock signal, positive edge-triggered
    input  logic reset,          // Active high synchronous reset
    input  logic data,           // Serial data input, one bit
    input  logic done_counting,  // Signal indicating completion of counting
    input  logic ack,            // Acknowledge signal from user
    output logic shift_ena,      // Enable signal for shifting operation
    output logic counting,       // Signal indicating counting is in progress
    output logic done            // Signal indicating timer completion
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        SHIFT = 2'b01,
        COUNT = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift_reg;
    logic [1:0] shift_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            pattern_shift_reg <= 4'b0000;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 2'b00;
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
                pattern_shift_reg = {pattern_shift_reg[2:0], data};
                if (pattern_shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
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