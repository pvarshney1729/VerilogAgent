module TopModule (
    input logic clk,          // Clock signal
    input logic reset,        // Active-high synchronous reset
    input logic [7:0] in,     // 8-bit input byte stream
    output logic [23:0] out_bytes, // 24-bit output representing the 3-byte message
    output logic done         // 1-bit signal indicating message receipt
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        BYTE1 = 3'b001,
        BYTE2 = 3'b010,
        BYTE3 = 3'b011,
        DONE  = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'bx;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Combinational logic for next state and output bytes
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                    out_bytes[23:16] = in;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                out_bytes[15:8] = in;
            end
            BYTE2: begin
                next_state = BYTE3;
                out_bytes[7:0] = in;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule