```verilog
[BEGIN]
module TopModule (
    input logic clk,         // Clock signal (1-bit, positive edge-triggered)
    input logic reset,       // Active-high synchronous reset (1-bit)
    input logic in,          // Serial data input (1-bit)
    output logic done        // Done signal indicating a valid byte is received (1-bit)
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START_DETECTED = 3'b001,
        RECEIVE_BITS = 3'b010,
        VERIFY_STOP = 3'b011,
        BYTE_RECEIVED = 3'b100,
        ERROR = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter;
    logic [7:0] data_byte;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            data_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_BITS) begin
                data_byte <= {in, data_byte[7:1]};
                bit_counter <= bit_counter + 3'b001;
            end
            if (current_state == BYTE_RECEIVED) begin
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
                    next_state = START_DETECTED;
                end
            end
            START_DETECTED: begin
                next_state = RECEIVE_BITS;
            end
            RECEIVE_BITS: begin
                if (bit_counter == 3'b111) begin
                    next_state = VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                if (in == 1'b1) begin
                    next_state = BYTE_RECEIVED;
                end else begin
                    next_state = ERROR;
                end
            end
            BYTE_RECEIVED: begin
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
[DONE]
```