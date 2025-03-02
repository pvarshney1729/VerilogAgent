module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
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
            if (current_state == BYTE3) begin
                out_bytes <= byte_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
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
        endcase
    end

    // Byte buffer logic
    always_ff @(posedge clk) begin
        if (reset) begin
            byte_buffer <= 24'b0;
        end else begin
            case (current_state)
                BYTE1: byte_buffer[23:16] <= in;
                BYTE2: byte_buffer[15:8] <= in;
                BYTE3: byte_buffer[7:0] <= in;
                default: byte_buffer <= byte_buffer;
            endcase
        end
    end

endmodule