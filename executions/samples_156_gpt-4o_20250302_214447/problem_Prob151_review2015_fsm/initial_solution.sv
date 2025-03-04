module TopModule (
    input  logic clk,          // Clock input
    input  logic reset,        // Active high synchronous reset
    input  logic data,         // Serial data input
    input  logic done_counting,// Counter done signal
    input  logic ack,          // Acknowledge signal from user
    output logic shift_ena,    // Shift enable signal
    output logic counting,     // Counting state signal
    output logic done          // Done signal
);

    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        SHIFT   = 2'b01,
        COUNT   = 2'b10,
        NOTIFY  = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift;
    logic [1:0] shift_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
            pattern_shift <= 4'b0000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (current_state)
            IDLE: begin
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT;
                end
            end

            SHIFT: begin
                shift_ena = 1;
                if (shift_counter == 3) begin
                    next_state = COUNT;
                    shift_counter = 0;
                end else begin
                    shift_counter = shift_counter + 1;
                end
            end

            COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = NOTIFY;
                end
            end

            NOTIFY: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule