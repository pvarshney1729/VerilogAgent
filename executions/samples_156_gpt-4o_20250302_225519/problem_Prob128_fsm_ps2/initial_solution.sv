module TopModule (
    input logic clk,        // Clock signal, positive edge triggered.
    input logic reset,      // Synchronous active high reset.
    input logic [7:0] in,   // 8-bit input stream, where bit[0] is LSB.
    output logic done       // Output signal, high for one clock cycle after message receipt.
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in[3]) state <= BYTE1;
                end
                BYTE1: begin
                    state <= BYTE2;
                end
                BYTE2: begin
                    state <= BYTE3;
                end
                BYTE3: begin
                    state <= IDLE;
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule