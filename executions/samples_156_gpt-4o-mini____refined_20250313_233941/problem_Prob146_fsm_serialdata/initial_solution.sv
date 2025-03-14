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
    logic [3:0] bit_count;
    logic [7:0] data_byte;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0;
            data_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_byte[bit_count] <= in;
            end
            if (current_state == START) begin
                bit_count <= 4'b0;
            end else if (current_state == DATA) begin
                bit_count <= bit_count + 1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA; // Move to data state after start bit
            end
            DATA: begin
                if (bit_count == 4'd7) begin
                    next_state = STOP; // After receiving 8 bits
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1; // Signal that byte is done
                    next_state = IDLE; // Return to idle
                end else begin
                    next_state = STOP; // Wait for correct stop bit
                end
            end
        endcase
    end

    assign out_byte = (done) ? data_byte : 8'b0;

endmodule
```
[DONE]