[BEGIN]
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
        IDLE        = 3'b000,
        DETECT_1    = 3'b001,
        DETECT_11   = 3'b010,
        DETECT_110  = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT       = 3'b101,
        COUNT       = 3'b110,
        DONE        = 3'b111
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
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else begin
                shift_counter <= 3'b000;
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
                if (data == 1'b1)
                    next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data == 1'b1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 1'b0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1'b1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b011)
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]