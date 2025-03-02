module TopModule (
    input logic clk,               // Clock signal, positive edge triggered
    input logic reset,             // Active high synchronous reset
    input logic data,              // Serial data input, 1-bit
    input logic done_counting,     // 1-bit signal indicating counting completion
    input logic ack,               // 1-bit acknowledgment input
    output logic shift_ena,        // 1-bit output, active during bit shift
    output logic counting,         // 1-bit output, active during counting phase
    output logic done              // 1-bit output, active when timer is done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        COUNT = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1 && shift_counter == 0) begin
                    shift_counter <= 1;
                end else if (shift_counter == 3) begin
                    next_state <= SHIFT;
                    shift_counter <= 0;
                end else if (data == 0) begin
                    shift_counter <= 0;
                end
            end
            SHIFT: begin
                shift_ena <= 1;
                if (shift_counter < 3) begin
                    shift_counter <= shift_counter + 1;
                end else begin
                    shift_ena <= 0;
                    next_state <= COUNT;
                end
            end
            COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    next_state <= DONE;
                end
            end
            DONE: begin
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                end
            end
        endcase
    end

    always_comb begin
        case (current_state)
            IDLE: next_state = (shift_counter == 3) ? SHIFT : IDLE;
            SHIFT: next_state = (shift_counter == 3) ? COUNT : SHIFT;
            COUNT: next_state = (done_counting) ? DONE : COUNT;
            DONE: next_state = (ack) ? IDLE : DONE;
            default: next_state = IDLE;
        endcase
    end

endmodule