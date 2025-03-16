module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic data,
    input  logic done_counting,
    input  logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        WAIT_PATTERN,
        SHIFT,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_count <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_count <= shift_count + 1;
            end else if (current_state == DONE && ack) begin
                shift_count <= 4'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN;
                end
            end
            
            WAIT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN; // Stay in this state
                end else if (data == 1'b0) begin
                    next_state = IDLE; // Reset to IDLE if pattern not found
                end else if (data == 1'b1) begin
                    next_state = SHIFT; // Detected 1101 pattern
                end
            end
            
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 4'b0011) begin // Shift for 4 cycles
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
                    next_state = IDLE; // Wait for ack to reset
                end
            end
        endcase
    end

endmodule