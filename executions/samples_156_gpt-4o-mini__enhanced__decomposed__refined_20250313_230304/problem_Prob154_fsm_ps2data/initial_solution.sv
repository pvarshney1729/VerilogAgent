[BEGIN]
module TopModule (
    input logic clk,             // Clock signal (positive edge triggered)
    input logic reset,           // Active high synchronous reset
    input logic [7:0] in,       // Input byte (8 bits), unsigned
    output logic [23:0] out_bytes, // Output data (24 bits)
    output logic done           // Indicates the receipt of a complete message
);

    typedef enum logic [2:0] {
        IDLE,
        RECEIVE_BYTE_1,
        RECEIVE_BYTE_2,
        SEND_MESSAGE
    } state_t;

    state_t current_state, next_state;
    logic [23:0] byte_buffer;
    logic [1:0] byte_count;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
            byte_count <= 2'b0;
        end else begin
            current_state <= next_state;

            if (current_state == SEND_MESSAGE) begin
                out_bytes <= byte_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Combinational logic for state transition and byte reception
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTE_1;
                    byte_buffer = 24'b0; // Reset buffer
                    byte_count = 2'b0;    // Reset byte count
                end
            end
            RECEIVE_BYTE_1: begin
                byte_buffer[23:16] = in; // First byte
                byte_count = byte_count + 1;
                next_state = RECEIVE_BYTE_2;
            end
            RECEIVE_BYTE_2: begin
                byte_buffer[15:8] = in; // Second byte
                byte_count = byte_count + 1;
                next_state = SEND_MESSAGE;
            end
            SEND_MESSAGE: begin
                byte_buffer[7:0] = in; // Third byte
                next_state = IDLE; // Go back to IDLE after sending
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
[DONE]