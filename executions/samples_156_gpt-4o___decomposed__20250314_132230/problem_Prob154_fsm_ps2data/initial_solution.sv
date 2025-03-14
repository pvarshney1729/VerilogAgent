```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        WAIT_FOR_START = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10,
        MESSAGE_COMPLETE = 2'b11
    } state_t;

    state_t state, next_state;
    logic [23:0] message_buffer;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= WAIT_FOR_START;
            done <= 1'b0;
            out_bytes <= 24'b0;
        end else begin
            state <= next_state;
            if (state == MESSAGE_COMPLETE) begin
                done <= 1'b1;
                out_bytes <= message_buffer;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (!reset) begin
            case (state)
                WAIT_FOR_START: begin
                    if (in[3] == 1'b1) begin
                        message_buffer[23:16] <= in;
                        next_state <= BYTE1_RECEIVED;
                    end else begin
                        next_state <= WAIT_FOR_START;
                    end
                end
                BYTE1_RECEIVED: begin
                    message_buffer[15:8] <= in;
                    next_state <= BYTE2_RECEIVED;
                end
                BYTE2_RECEIVED: begin
                    message_buffer[7:0] <= in;
                    next_state <= MESSAGE_COMPLETE;
                end
                MESSAGE_COMPLETE: begin
                    next_state <= WAIT_FOR_START;
                end
                default: next_state <= WAIT_FOR_START;
            endcase
        end
    end

endmodule
```