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
        IDLE = 3'b000,
        S1 = 3'b001,
        S11 = 3'b010,
        S110 = 3'b011,
        PATTERN_DETECT = 3'b100,
        SHIFT = 3'b101,
        COUNTING = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    // State register update logic
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
        next_state = current_state; // Default to hold state
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (data) next_state = S1;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = IDLE;
            end
            S11: begin
                if (!data) next_state = S110;
                else next_state = S1;
            end
            S110: begin
                if (data) next_state = PATTERN_DETECT;
                else next_state = IDLE;
            end
            PATTERN_DETECT: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b100) next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule