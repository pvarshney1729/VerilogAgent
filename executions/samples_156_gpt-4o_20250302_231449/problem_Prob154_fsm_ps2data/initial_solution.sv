```verilog
module TopModule (
    input logic clk,               // Clock signal, positive edge triggered
    input logic reset,             // Active high synchronous reset
    input logic [7:0] in,          // 8-bit input byte stream
    output logic [23:0] out_bytes, // 24-bit output, valid when done is high
    output logic done              // Output indicating message receipt completion
);

    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] temp_bytes;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE_3) begin
                out_bytes <= temp_bytes;
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
                    next_state = BYTE_1;
                end
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = BYTE_3;
            end
            BYTE_3: begin
                next_state = IDLE;
            end
        endcase
    end

    // Temporary byte storage logic
    always_ff @(posedge clk) begin
        if (reset) begin
            temp_bytes <= 24'b0;
        end else begin
            case (current_state)
                BYTE_1: temp_bytes[23:16] <= in;
                BYTE_2: temp_bytes[15:8] <= in;
                BYTE_3: temp_bytes[7:0] <= in;
            endcase
        end
    end

endmodule
```