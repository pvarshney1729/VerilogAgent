module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        FIRST_BYTE = 2'b01,
        SECOND_BYTE = 2'b10,
        THIRD_BYTE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] byte_buffer;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == THIRD_BYTE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (!reset) begin
            case (current_state)
                FIRST_BYTE: byte_buffer[23:16] <= in;
                SECOND_BYTE: byte_buffer[15:8] <= in;
                THIRD_BYTE: byte_buffer[7:0] <= in;
                default: byte_buffer <= byte_buffer;
            endcase
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: if (in[3]) next_state = FIRST_BYTE;
            FIRST_BYTE: next_state = SECOND_BYTE;
            SECOND_BYTE: next_state = THIRD_BYTE;
            THIRD_BYTE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    assign out_bytes = byte_buffer;

endmodule