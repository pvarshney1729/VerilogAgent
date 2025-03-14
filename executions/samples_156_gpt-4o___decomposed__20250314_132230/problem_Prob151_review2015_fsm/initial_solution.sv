module TopModule (
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
        IDLE = 3'b000,
        DETECT_1 = 3'b001,
        DETECT_11 = 3'b010,
        DETECT_110 = 3'b011,
        SHIFT = 3'b100,
        WAIT_COUNT = 3'b101,
        WAIT_ACK = 3'b110
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT)
                shift_count <= shift_count + 1;
            else
                shift_count <= 2'b00;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

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
                if (!data)
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
                shift_ena = 1'b1;
                if (shift_count == 2'b11)
                    next_state = WAIT_COUNT;
            end
            WAIT_COUNT: begin
                counting = 1'b1;
                if (done_counting)
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end
endmodule