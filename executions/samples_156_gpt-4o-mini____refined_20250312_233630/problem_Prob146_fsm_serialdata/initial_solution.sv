[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_buffer;
    logic [2:0] bit_count;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_buffer <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 3'b001;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA; // Move to data state after start bit
            end
            DATA: begin
                if (bit_count == 3'b111) // 8 bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    next_state = IDLE;
                end else begin
                    next_state = STOP; // Wait for stop bit
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign done = (current_state == STOP && in == 1'b1);
    assign out_byte = (done) ? data_buffer : 8'b00000000;

endmodule
```
[DONE]