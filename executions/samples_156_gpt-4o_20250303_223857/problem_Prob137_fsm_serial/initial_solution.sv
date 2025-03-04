module TopModule (
    input logic clk,          // Clock signal, triggers on the positive edge
    input logic reset,        // Active-high synchronous reset
    input logic in,           // Serial input bit stream
    output logic done         // Output high when a byte is correctly received
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        RECEIVE_BITS = 3'b010,
        CHECK_STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_shift_reg;
    logic [3:0] bit_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_shift_reg <= 8'b0;
            bit_counter <= 4'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_BITS) begin
                data_shift_reg <= {in, data_shift_reg[7:1]};
                bit_counter <= bit_counter + 1;
            end
            if (current_state == CHECK_STOP_BIT && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = RECEIVE_BITS;
            end
            RECEIVE_BITS: begin
                if (bit_counter == 4'd8) begin
                    next_state = CHECK_STOP_BIT;
                end
            end
            CHECK_STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
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