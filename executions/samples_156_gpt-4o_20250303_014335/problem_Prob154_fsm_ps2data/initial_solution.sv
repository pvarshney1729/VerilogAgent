module TopModule(
    input logic clk,          // Clock signal, positive-edge triggered
    input logic reset,        // Active-high synchronous reset
    input logic [7:0] in,     // 8-bit input bus, bit[7] is MSB, bit[0] is LSB
    output logic [23:0] out_bytes, // 24-bit output
    output logic done         // High when a complete message is received
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        BYTE1 = 3'b001,
        BYTE2 = 3'b010,
        BYTE3 = 3'b011,
        DONE  = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [23:0] temp_bytes;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                BYTE1: temp_bytes[23:16] <= in;
                BYTE2: temp_bytes[15:8] <= in;
                BYTE3: temp_bytes[7:0] <= in;
                DONE: begin
                    out_bytes <= temp_bytes;
                    done <= 1'b1;
                end
                default: done <= 1'b0;
            endcase
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
            BYTE3: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule