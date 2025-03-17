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
    logic [23:0] message_buffer;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message_buffer <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (done) begin
                out_bytes <= message_buffer;
            end
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                    message_buffer[23:16] = in;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                message_buffer[15:8] = in;
            end
            BYTE2: begin
                next_state = BYTE3;
                message_buffer[7:0] = in;
            end
            BYTE3: begin
                done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule