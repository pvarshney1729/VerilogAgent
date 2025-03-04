```verilog
module TopModule (
    input logic clk,               // Clock signal, positive edge triggered
    input logic reset,             // Synchronous active-high reset
    input logic [7:0] in,          // 8-bit input stream
    output logic [23:0] out_bytes, // 24-bit output message
    output logic done              // 1-bit done signal, active high
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10,
        BYTE3_RECEIVED = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] message_buffer;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE3_RECEIVED) begin
                out_bytes <= message_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1_RECEIVED;
                end
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
            end
            BYTE3_RECEIVED: begin
                next_state = IDLE;
            end
        endcase
    end

    // Message buffer logic
    always_ff @(posedge clk) begin
        if (reset) begin
            message_buffer <= 24'b0;
        end else begin
            case (current_state)
                BYTE1_RECEIVED: begin
                    message_buffer[23:16] <= in;
                end
                BYTE2_RECEIVED: begin
                    message_buffer[15:8] <= in;
                end
                BYTE3_RECEIVED: begin
                    message_buffer[7:0] <= in;
                end
            endcase
        end
    end

endmodule
```