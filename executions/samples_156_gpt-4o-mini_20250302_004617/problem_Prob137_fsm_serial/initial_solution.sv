module shift_register (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [7:0] data_out,
    output logic valid
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE,
        VERIFY_STOP,
        VALIDATE
    } state_t;

    state_t current_state, next_state;
    logic [7:0] shift_reg;
    logic stop_bit;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= 2'b00; // IDLE state
            shift_reg <= 8'b00000000;
            valid <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                shift_reg <= {serial_in, shift_reg[7:1]};
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        valid = 1'b0;
        case (current_state)
            IDLE: begin
                if (serial_in == 1'b0) begin // Start bit detected
                    next_state = RECEIVE;
                end
            end
            RECEIVE: begin
                if (shift_reg[7] == 1'b1) begin // Assuming 8 bits received
                    next_state = VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                stop_bit = serial_in; // Read stop bit
                if (stop_bit == 1'b1) begin
                    valid = 1'b1; // Valid data received
                end
                next_state = IDLE; // Go back to IDLE
            end
        endcase
    end

    assign data_out = shift_reg;

endmodule