module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        WAIT_FOR_FIRST_BYTE,
        RECEIVE_BYTES,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [23:0] message_buffer;
    logic [2:0] byte_count;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 3'b000;
            message_buffer <= 24'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTES;
                    byte_count = 3'b001;
                    message_buffer[23:16] = in;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE_BYTES: begin
                if (byte_count < 3) begin
                    next_state = RECEIVE_BYTES;
                    byte_count = byte_count + 1;
                    message_buffer[(23 - (byte_count * 8)) -: 8] = in;
                end else begin
                    next_state = DONE_STATE;
                end
            end
            DONE_STATE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            if (current_state == DONE_STATE) begin
                out_bytes <= message_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule