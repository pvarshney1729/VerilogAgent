```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10,
        MESSAGE_RECEIVED = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] message_buffer;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message_buffer <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == MESSAGE_RECEIVED) begin
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
                    message_buffer[23:16] = in;
                end
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
                message_buffer[15:8] = in;
            end
            BYTE2_RECEIVED: begin
                next_state = MESSAGE_RECEIVED;
                message_buffer[7:0] = in;
            end
            MESSAGE_RECEIVED: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```