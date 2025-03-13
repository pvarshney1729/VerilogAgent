[BEGIN]
module TopModule (
    input logic clk,            // Clock signal, triggers on positive edge
    input logic reset,          // Active high synchronous reset
    input logic [7:0] in,       // 8-bit input data stream
    output logic [23:0] out_bytes, // 24-bit output for message data
    output logic done            // Done signal, indicates message receipt
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
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
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case (current_state)
                BYTE1: out_bytes[23:16] <= in;
                BYTE2: out_bytes[15:8] <= in;
                BYTE3: begin
                    out_bytes[7:0] <= in;
                    done <= 1'b1;
                end
                default: done <= 1'b0;
            endcase
        end
    end

endmodule
[DONE]