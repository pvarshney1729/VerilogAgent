module TopModule (
    input logic clk,               // Clock input
    input logic reset,             // Active high synchronous reset
    input logic data,              // Serial data input
    input logic done_counting,     // Input indicating counting is done
    input logic ack,               // Acknowledgment from the user
    output logic shift_ena,        // Output to enable shifting
    output logic counting,         // Output indicating counting is in progress
    output logic done              // Output indicating the timer has completed
);

    typedef enum logic [3:0] {
        IDLE  = 4'b0001,
        SHIFT = 4'b0010,
        COUNT = 4'b0100,
        DONE  = 4'b1000
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