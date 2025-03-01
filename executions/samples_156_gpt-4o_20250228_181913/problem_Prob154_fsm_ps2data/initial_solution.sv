module TopModule (
    input logic clk,              // Clock signal, triggered on positive edge
    input logic reset,            // Active high synchronous reset
    input logic [7:0] in,         // 8-bit input data stream
    output logic [23:0] out_bytes, // 24-bit output representing 3 concatenated bytes
    output logic done              // Signal asserted when a 3-byte message is received
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] byte_buffer;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (next_state == BYTE1) begin
                byte_buffer[23:16] <= in;
            end else if (next_state == BYTE2) begin
                byte_buffer[15:8] <= in;
            end else if (next_state == BYTE3) begin
                byte_buffer[7:0] <= in;
            end
            if (next_state == IDLE) begin
                done <= 1'b0;
            end else if (next_state == BYTE3) begin
                out_bytes <= byte_buffer;
                done <= 1'b1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule