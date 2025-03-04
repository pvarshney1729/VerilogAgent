module TopModule (
    input logic clk,               // Clock signal, positive edge triggered
    input logic reset,             // Reset signal, active high, synchronous
    input logic [7:0] in,          // 8-bit input bus, bit[0] is LSB, bit[7] is MSB
    output logic done              // Output signal, goes high one cycle after a complete 3-byte message
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = BYTE_3;
            end
            BYTE_3: begin
                done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule