```verilog
[BEGIN]
module TopModule (
    input logic clk,        // Clock input (1 bit)
    input logic reset,      // Active high synchronous reset (1 bit)
    input logic [7:0] in,   // 8-bit input byte stream
    output logic done       // Output signal indicating message receipt (1 bit)
);
    // State encoding
    typedef enum logic [1:0] {
        IDLE               = 2'b00,
        BYTE1_RECEIVED     = 2'b01,
        BYTE2_RECEIVED     = 2'b10,
        BYTE3_RECEIVED     = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
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
                    next_state = BYTE1_RECEIVED;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
            end
            BYTE3_RECEIVED: begin
                next_state = IDLE; // Go back to IDLE after receiving 3rd byte
            end
            default: next_state = IDLE; // Default case
        endcase
    end

    // Done signal logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
        end else begin
            if (current_state == BYTE3_RECEIVED) begin
                done <= 1'b1; // Assert done when byte 3 is received
            end else begin
                done <= 1'b0; // Deassert done otherwise
            end
        end
    end
endmodule
[DONE]
```