[BEGIN]
module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        RECEIVE_START,
        RECEIVE_DATA,
        CHECK_STOP,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;
    logic [7:0] data_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'd0;
            data_reg <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        done = 1'b0; // Default done value
        out_byte = 8'b0; // Default don't-care value

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = RECEIVE_START;
            end
            RECEIVE_START: begin
                bit_count = 4'd0; // Reset bit count
                next_state = RECEIVE_DATA;
            end
            RECEIVE_DATA: begin
                if (bit_count < 4'd8) begin
                    data_reg[bit_count] = in; // Capture data bits
                    bit_count = bit_count + 1;
                end else begin
                    next_state = CHECK_STOP;
                end
            end
            CHECK_STOP: begin
                if (in == 1'b1) begin // Check for correct stop bit
                    next_state = DONE;
                end else begin
                    next_state = IDLE; // Incorrect stop bit, reset to idle
                end
            end
            DONE: begin
                done = 1'b1; // Assert done
                next_state = IDLE; // Return to idle state
            end
            default: next_state = IDLE;
        endcase
    end

    assign out_byte = (current_state == DONE) ? data_reg : 8'b0; // Output valid data byte in Done state

endmodule
[DONE]