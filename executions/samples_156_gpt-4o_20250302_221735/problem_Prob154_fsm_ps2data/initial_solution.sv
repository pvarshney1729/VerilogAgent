module TopModule (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic reset,          // Synchronous reset, active high
    input logic [7:0] in,       // 8-bit input byte stream, unsigned
    output logic [23:0] out_bytes, // 24-bit output, unsigned
    output logic done           // Output signal indicating message receipt
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
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
            if (current_state == BYTE_3) begin
                out_bytes <= message_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic and message buffer update
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                    message_buffer[23:16] = in;
                end
            end
            BYTE_1: begin
                next_state = BYTE_2;
                message_buffer[15:8] = in;
            end
            BYTE_2: begin
                next_state = BYTE_3;
                message_buffer[7:0] = in;
            end
            BYTE_3: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule