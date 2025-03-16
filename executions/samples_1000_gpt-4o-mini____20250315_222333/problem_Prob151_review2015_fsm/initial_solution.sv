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
        CHECK1,
        CHECK2,
        CHECK3,
        SHIFT,
        COUNT,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [1:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_counter <= shift_counter + 1;
            end else if (current_state == IDLE) begin
                shift_counter <= 2'b00;
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
                if (data == 1'b1) next_state = CHECK1;
            end
            CHECK1: begin
                if (data == 1'b1) next_state = CHECK2;
                else next_state = IDLE;
            end
            CHECK2: begin
                if (data == 1'b0) next_state = CHECK3;
                else next_state = IDLE;
            end
            CHECK3: begin
                if (data == 1'b1) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE_STATE;
            end
            DONE_STATE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule