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
        COUNTING = 3'b101,
        DONE_STATE = 3'b110
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 3'b000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state; // Default to hold current state
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (data) next_state = DETECT_1;
            end
            DETECT_1: begin
                if (data) next_state = DETECT_11;
                else next_state = IDLE;
            end
            DETECT_11: begin
                if (data) next_state = DETECT_110;
                else next_state = IDLE;
            end
            DETECT_110: begin
                if (!data) next_state = SHIFT; // On 0, transition to SHIFT
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1; // Enable shifting
                shift_counter <= shift_counter + 1;
                if (shift_counter == 3'b011) begin // After 4 cycles
                    next_state = COUNTING;
                    shift_counter <= 3'b000;
                end
            end
            COUNTING: begin
                counting = 1'b1; // Indicate counting is occurring
                if (done_counting) next_state = DONE_STATE;
            end
            DONE_STATE: begin
                done = 1'b1; // Notify done
                if (ack) next_state = IDLE; // Wait for ack to reset
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly