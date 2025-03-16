module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);
    typedef enum logic [2:0] {
        IDLE,
        WAIT_FOR_PATTERN,
        SHIFT,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 3'b000;
        end else begin
            current_state <= next_state;
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
                if (data == 1'b1) begin
                    next_state = WAIT_FOR_PATTERN;
                end
            end
            
            WAIT_FOR_PATTERN: begin
                if (data == 1'b1) begin
                    // Assuming we have detected the first '1'
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end
            
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter < 3'b011) begin // Shift for 4 cycles
                    shift_counter <= shift_counter + 1;
                    next_state = SHIFT;
                end else begin
                    shift_counter <= 3'b000; // Reset counter after 4 cycles
                    next_state = COUNTING;
                end
            end
            
            COUNTING: begin
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
            
            default: next_state = IDLE;
        endcase
    end
endmodule