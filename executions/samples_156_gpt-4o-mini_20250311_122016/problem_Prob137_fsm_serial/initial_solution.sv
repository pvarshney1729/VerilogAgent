[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE        = 2'b00,
        RECEIVE     = 2'b01,
        VERIFY_STOP = 2'b10,
        ERROR       = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_reg;   // Register to store the incoming 8 data bits
    logic [3:0] bit_count;  // Count the number of data bits received

    // Sequential logic for state transitions and output
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            data_reg <= 8'b0;
            bit_count <= 4'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and done signal
    always @(*) begin
        next_state = current_state; // Default to hold state
        done = 1'b0; // Default to inactive

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = RECEIVE;
                    bit_count = 4'b0;
                end
            end

            RECEIVE: begin
                if (bit_count == 4'd8) begin
                    next_state = VERIFY_STOP;
                end else begin
                    bit_count = bit_count + 1'b1;
                    data_reg = {in, data_reg[7:1]}; // Shift in the data bit
                end
            end

            VERIFY_STOP: begin
                if (in == 1'b1) begin // Correct stop bit
                    done = 1'b1; // Byte received successfully
                    next_state = IDLE;
                end else begin
                    next_state = ERROR; // Incorrect stop bit
                end
            end

            ERROR: begin
                if (in == 1'b1) begin // Wait for line to be idle
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
[DONE]