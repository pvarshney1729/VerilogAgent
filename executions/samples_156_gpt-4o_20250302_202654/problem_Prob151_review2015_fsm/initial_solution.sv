module TopModule (
    input  logic clk,          // Clock signal, positive edge-triggered
    input  logic reset,        // Active high synchronous reset
    input  logic data,         // Serial data input
    input  logic done_counting,// Indicates completion of counting
    input  logic ack,          // Acknowledgment from the user
    output logic shift_ena,    // Enable signal for shifting
    output logic counting,     // Indicates counting is in progress
    output logic done          // Indicates the timer has timed out
);

    typedef enum logic [2:0] {
        IDLE   = 3'b000,
        SHIFT  = 3'b001,
        COUNT  = 3'b010,
        DONE   = 3'b011
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift;
    logic [1:0] shift_counter;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            pattern_shift <= 4'b0000;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    pattern_shift <= {data, pattern_shift[3:1]};
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    shift_counter <= shift_counter + 1;
                end
                COUNT: begin
                    counting <= 1'b1;
                end
                DONE: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = SHIFT;
                end
            end
            SHIFT: begin
                if (shift_counter == 2'b11) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done_counting) begin
                    next_state = DONE;
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