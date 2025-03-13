```verilog
[BEGIN]
module TopModule (
    input logic clk,                // Clock signal (positive edge triggered)
    input logic reset,              // Active high synchronous reset
    input logic [7:0] in,           // Input byte (8 bits, unsigned)
    output logic [23:0] out_bytes,  // Output message (3 bytes, 24 bits, unsigned)
    output logic done               // Signal indicating message receipt (1 bit)
);

    typedef enum logic [1:0] {
        WAIT_FOR_START, // State 0
        RECEIVE_BYTE1,  // State 1
        RECEIVE_BYTE2,  // State 2
        RECEIVE_BYTE3   // State 3
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_FOR_START;
            out_bytes <= 24'h000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state; // Default to stay in current state
        done = 1'b0; // Default done signal is low

        case (current_state)
            WAIT_FOR_START: begin
                if (in[3]) begin
                    next_state = RECEIVE_BYTE1;
                end
            end

            RECEIVE_BYTE1: begin
                out_bytes[23:16] = in;
                next_state = RECEIVE_BYTE2;
            end

            RECEIVE_BYTE2: begin
                out_bytes[15:8] = in;
                next_state = RECEIVE_BYTE3;
            end

            RECEIVE_BYTE3: begin
                out_bytes[7:0] = in;
                done = 1'b1; // Assert done after receiving the third byte
                next_state = WAIT_FOR_START; // Return to waiting for start
            end
        endcase
    end
endmodule
[DONE]
```