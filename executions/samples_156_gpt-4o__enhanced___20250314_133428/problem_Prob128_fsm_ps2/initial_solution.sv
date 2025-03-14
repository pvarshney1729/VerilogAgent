```verilog
module TopModule (
    input logic clk,            // Clock signal, positive edge triggered
    input logic reset,          // Active high synchronous reset
    input logic [7:0] in,       // 8-bit input data stream
    output logic done           // Done signal, indicates message completion
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state;   // State register

    // Sequential logic for FSM transitions
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
                BYTE1: state <= BYTE2;
                BYTE2: state <= BYTE3;
                BYTE3: begin
                    done <= 1'b1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
```