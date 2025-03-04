module pattern_detector (
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
        WAIT_PATTERN,
        SHIFT,
        COUNT,
        DONE,
        WAIT_ACK
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_PATTERN;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            WAIT_PATTERN: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                // Pattern detection logic should be implemented here
            end
            
            SHIFT: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            
            COUNT: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end
            
            DONE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
            end
            
            WAIT_ACK: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        endcase
    end

    always_comb begin
        case (current_state)
            WAIT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = SHIFT; // Assuming pattern detected
                end else begin
                    next_state = WAIT_PATTERN;
                end
            end
            
            SHIFT: begin
                // After 4 clock cycles, transition to COUNT
                next_state = COUNT;
            end
            
            COUNT: begin
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT;
                end
            end
            
            DONE: begin
                next_state = WAIT_ACK;
            end
            
            WAIT_ACK: begin
                if (ack) begin
                    next_state = WAIT_PATTERN;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            
            default: next_state = WAIT_PATTERN;
        endcase
    end

endmodule