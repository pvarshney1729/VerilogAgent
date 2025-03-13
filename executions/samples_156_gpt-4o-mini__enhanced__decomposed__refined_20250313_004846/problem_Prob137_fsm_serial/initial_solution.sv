```verilog
[BEGIN]
module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Active-high synchronous reset
    input logic in,           // Serial input bit stream
    output logic done         // Output signal, high when a valid byte is received
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        ERROR = 3'b100
    } state_t;

    // State register
    state_t current_state, next_state;
    logic [3:0] bit_counter; // Counter for 8 data bits

    // Sequential logic for state transition and bit counting
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 4'b0000;
            end
        end
    end

    // Combinational logic for state transitions
    always @(*) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 4'b1000) begin // 8 bits received
                    if (in == 1'b1)
                        next_state = STOP;
                    else
                        next_state = ERROR;
                end
            end
            STOP: begin
                done = 1'b1;
                next_state = IDLE;
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end
endmodule
[DONE]
```