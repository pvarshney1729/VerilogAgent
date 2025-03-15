module TopModule (
    input clk,
    input reset,
    input data,
    input done_counting,
    input ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        SHIFT,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == SHIFT) begin
            shift_ena <= 1'b1;
            shift_counter <= shift_counter + 1;
        end else begin
            shift_ena <= 1'b0;
        end

        if (current_state == COUNTING) begin
            counting <= 1'b1;
        end else begin
            counting <= 1'b0;
        end

        if (current_state == DONE) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (data) 
                    next_state = DETECT_1;
            end

            DETECT_1: begin
                if (data) 
                    next_state = DETECT_11;
                else 
                    next_state = IDLE;
            end

            DETECT_11: begin
                if (data) 
                    next_state = DETECT_110;
                else 
                    next_state = IDLE;
            end

            DETECT_110: begin
                if (data) 
                    next_state = SHIFT;
                else 
                    next_state = IDLE;
            end

            SHIFT: begin
                if (shift_counter == 4'b0011) begin
                    next_state = COUNTING;
                    shift_counter <= 4'b0000;
                end
            end

            COUNTING: begin
                if (done_counting) 
                    next_state = DONE;
            end

            DONE: begin
                if (ack) 
                    next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule