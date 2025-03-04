module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] collected_bytes;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            collected_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE_3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            collected_bytes <= 24'b0;
        end else begin
            case (current_state)
                BYTE_1: collected_bytes[23:16] <= in;
                BYTE_2: collected_bytes[15:8] <= in;
                BYTE_3: collected_bytes[7:0] <= in;
                default: collected_bytes <= collected_bytes;
            endcase
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE_1: next_state = BYTE_2;
            BYTE_2: next_state = BYTE_3;
            BYTE_3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    assign out_bytes = collected_bytes;

endmodule