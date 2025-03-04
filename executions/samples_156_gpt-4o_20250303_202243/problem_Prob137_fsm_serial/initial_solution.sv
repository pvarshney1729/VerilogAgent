module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic reset,      // Active-high synchronous reset signal
    input logic in,         // Serial data input, single-bit, unsigned
    output logic done       // Active-high signal indicating a correctly received byte
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        RECEIVE = 3'b001,
        VERIFY_STOP = 3'b010,
        COMPLETE = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_shift_reg;
    logic [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_shift_reg <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = RECEIVE;
                    bit_count = 3'b0;
                end
            end

            RECEIVE: begin
                data_shift_reg = {in, data_shift_reg[7:1]};
                bit_count = bit_count + 1;
                if (bit_count == 3'b111) begin
                    next_state = VERIFY_STOP;
                end
            end

            VERIFY_STOP: begin
                if (in == 1'b1) begin
                    next_state = COMPLETE;
                end else begin
                    next_state = ERROR;
                end
            end

            COMPLETE: begin
                done = 1'b1;
                next_state = IDLE;
            end

            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule