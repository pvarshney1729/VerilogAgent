[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] byte_buffer;
    logic done_next;

    // State register and synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            out_bytes <= byte_buffer;
            done <= done_next;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        byte_buffer = out_bytes;
        done_next = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    byte_buffer[23:16] = in;
                    next_state = BYTE1;
                end
            end

            BYTE1: begin
                byte_buffer[15:8] = in;
                next_state = BYTE2;
            end

            BYTE2: begin
                byte_buffer[7:0] = in;
                next_state = BYTE3;
            end

            BYTE3: begin
                done_next = 1'b1;
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]