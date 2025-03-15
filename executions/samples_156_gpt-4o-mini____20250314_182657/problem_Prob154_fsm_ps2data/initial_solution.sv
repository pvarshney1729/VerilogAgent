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
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end
            end
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3]) begin
                    next_state = RECEIVE_BYTES;
                end else begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end
            end
            RECEIVE_BYTES: begin
                if (byte_count == 3) begin
                    next_state = DONE_STATE;
                end else begin
                    next_state = RECEIVE_BYTES;
                end
            end
            DONE_STATE: begin
                next_state = WAIT_FOR_FIRST_BYTE;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 3'b000;
            message_buffer <= 24'b0;
        end else begin
            current_state <= next_state;
            if (current_state == WAIT_FOR_FIRST_BYTE && in[3]) begin
                byte_count <= 3'b001;
                message_buffer[23:16] <= in;
            end else if (current_state == RECEIVE_BYTES) begin
                byte_count <= byte_count + 1;
                message_buffer <= {message_buffer[15:0], in};
            end else if (current_state == DONE_STATE) begin
                byte_count <= 3'b000;
            end
        end
    end

    // Output logic
    assign out_bytes = (current_state == DONE_STATE) ? message_buffer : 24'b0;
    assign done = (current_state == DONE_STATE);

endmodule