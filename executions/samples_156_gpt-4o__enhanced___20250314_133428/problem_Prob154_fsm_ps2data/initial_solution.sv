module TopModule(
    input logic clk,             // Clock input, positive edge triggered
    input logic reset,           // Synchronous active high reset, 1-bit
    input logic [7:0] in,        // 8-bit input byte stream
    output logic [23:0] out_bytes, // 24-bit output representing three received message bytes
    output logic done            // 1-bit output indicating message reception
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] message_buffer;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message_buffer <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE1) begin
                message_buffer[23:16] <= in;
            end else if (current_state == BYTE2) begin
                message_buffer[15:8] <= in;
            end else if (current_state == BYTE3) begin
                message_buffer[7:0] <= in;
            end
            done <= (current_state == BYTE3);
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        if (done) begin
            out_bytes = message_buffer;
        end else begin
            out_bytes = 24'bx; // Don't care when done is not asserted
        end
    end

endmodule