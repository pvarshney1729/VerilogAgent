```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
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

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 4'b0001;
            end else if (current_state == IDLE) begin
                bit_count <= 4'b0000;
            end
        end
    end

    always_comb begin
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
                if (bit_count == 4'b0111) begin // After receiving 8 bits
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1; // Byte received successfully
                    next_state = IDLE; // Go back to idle
                end
                // else stay in STOP state until valid stop bit is detected
            end
        endcase
    end

endmodule
[DONE]
```