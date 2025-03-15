module serial_receiver (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [7:0] data_out,
    output logic data_ready
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVING,
        STOP_BIT,
        VALIDATE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;
    logic [7:0] shift_reg;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0;
            shift_reg <= 8'b0;
            data_ready <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (serial_in == 1'b0) // Start bit detected
                    next_state = RECEIVING;
                else
                    next_state = IDLE;
            end
            RECEIVING: begin
                if (bit_count == 4'd7)
                    next_state = STOP_BIT;
                else
                    next_state = RECEIVING;
            end
            STOP_BIT: begin
                next_state = VALIDATE;
            end
            VALIDATE: begin
                next_state = IDLE; // Go back to IDLE after validation
            end
            default: next_state = IDLE;
        endcase
    end

    // Data reception and bit counting
    always @(posedge clk) begin
        if (current_state == RECEIVING) begin
            shift_reg <= {serial_in, shift_reg[7:1]};
            bit_count <= bit_count + 4'b1;
        end else if (current_state == STOP_BIT) begin
            // Check stop bit
            if (serial_in == 1'b1) begin
                data_ready <= 1'b1;
                data_out <= shift_reg;
            end else begin
                data_ready <= 1'b0; // Invalid stop bit
            end
        end else if (current_state == IDLE) begin
            bit_count <= 4'b0;
            data_ready <= 1'b0;
        end
    end

endmodule