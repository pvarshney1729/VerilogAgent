```verilog
[BEGIN]
module TopModule (
    input logic clk,             // Clock signal, positive edge triggered
    input logic reset,           // Active high synchronous reset
    input logic [7:0] in,        // 8-bit input signal representing the incoming byte stream
    output logic done            // Output signal indicating the receipt of a complete message
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        COMPLETE = 2'b11
    } state_t;

    state_t current_state, next_state;

    // FSM state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
                done = 1'b0; // done is not asserted in IDLE
            end
            BYTE1: begin
                next_state = BYTE2;
                done = 1'b0;
            end
            BYTE2: begin
                next_state = COMPLETE;
                done = 1'b0;
            end
            COMPLETE: begin
                next_state = IDLE;
                done = 1'b1; // Assert done in the cycle immediately after receiving the third byte
            end
            default: begin
                next_state = IDLE;
                done = 1'b0;
            end
        endcase
    end

endmodule
[DONE]
```