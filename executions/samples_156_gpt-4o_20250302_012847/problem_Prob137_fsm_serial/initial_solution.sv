module uart_fsm (
    input logic clk,
    input logic reset,
    input logic rx,
    output logic [7:0] data_out,
    output logic data_valid,
    output logic error
);

    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_RECEPTION,
        STOP_BIT,
        ERROR_RECOVERY
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter;
    logic [7:0] data_shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            data_shift_reg <= 8'b00000000;
            data_valid <= 1'b0;
            error <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = current_state;
        data_valid = 1'b0;
        error = 1'b0;

        case (current_state)
            IDLE: begin
                if (rx == 1'b0) begin // Start bit detected
                    next_state = START_BIT;
                end
            end

            START_BIT: begin
                if (rx == 1'b0) begin // Confirm start bit
                    next_state = DATA_RECEPTION;
                    bit_counter = 3'b000;
                end else begin
                    next_state = ERROR_RECOVERY;
                end
            end

            DATA_RECEPTION: begin
                data_shift_reg = {rx, data_shift_reg[7:1]};
                bit_counter = bit_counter + 1;
                if (bit_counter == 3'b111) begin
                    next_state = STOP_BIT;
                end
            end

            STOP_BIT: begin
                if (rx == 1'b1) begin // Stop bit verification
                    data_out = data_shift_reg;
                    data_valid = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR_RECOVERY;
                end
            end

            ERROR_RECOVERY: begin
                error = 1'b1;
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule