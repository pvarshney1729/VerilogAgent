module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVE_BYTE_1 = 2'b01,
        RECEIVE_BYTE_2 = 2'b10,
        RECEIVE_BYTE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] out_bytes_next;
    logic done_next;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            out_bytes <= out_bytes_next;
            done <= done_next;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        out_bytes_next = out_bytes;
        done_next = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTE_1;
                end
            end

            RECEIVE_BYTE_1: begin
                out_bytes_next[23:16] = in;
                next_state = RECEIVE_BYTE_2;
            end

            RECEIVE_BYTE_2: begin
                out_bytes_next[15:8] = in;
                next_state = RECEIVE_BYTE_3;
            end

            RECEIVE_BYTE_3: begin
                out_bytes_next[7:0] = in;
                done_next = 1'b1;
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule