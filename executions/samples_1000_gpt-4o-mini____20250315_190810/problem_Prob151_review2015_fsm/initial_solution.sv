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
        IDLE,
        WAIT_PATTERN,
        SHIFT,
        COUNTING,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                if (shift_counter < 4'b0011) begin
                    shift_counter <= shift_counter + 1;
                end else begin
                    shift_counter <= 4'b0000;
                end
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN;
                end else begin
                    next_state = IDLE;
                end
            end
            WAIT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN;
                end else if (data == 1'b0) begin
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT: begin
                if (shift_counter < 4'b0011) begin
                    next_state = SHIFT;
                end else begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    next_state = DONE_STATE;
                end else begin
                    next_state = COUNTING;
                end
            end
            DONE_STATE: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE_STATE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign shift_ena = (current_state == SHIFT);
    assign counting = (current_state == COUNTING);
    assign done = (current_state == DONE_STATE);

endmodule