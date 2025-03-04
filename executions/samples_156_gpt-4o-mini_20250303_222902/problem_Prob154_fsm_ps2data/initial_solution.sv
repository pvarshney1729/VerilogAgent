module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        BYTE1_RECEIVED,
        BYTE2_RECEIVED,
        BYTE3_RECEIVED
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE3_RECEIVED) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        out_bytes[23:16] <= in;
                        next_state <= BYTE1_RECEIVED;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                BYTE1_RECEIVED: begin
                    out_bytes[15:8] <= in;
                    next_state <= BYTE2_RECEIVED;
                end
                BYTE2_RECEIVED: begin
                    out_bytes[7:0] <= in;
                    next_state <= BYTE3_RECEIVED;
                end
                BYTE3_RECEIVED: begin
                    next_state <= IDLE;
                end
                default: next_state <= IDLE;
            endcase
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end
    end

endmodule