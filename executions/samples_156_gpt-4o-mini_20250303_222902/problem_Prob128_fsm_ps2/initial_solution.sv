module TopModule (
    input logic clk,                // Clock signal, positive edge-triggered
    input logic reset,              // Active high synchronous reset
    input logic [7:0] in,           // 8-bit input data stream from PS/2 mouse
    output logic done               // Output signal indicating message receipt
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1) 
                    next_state = BYTE1;
                else 
                    next_state = IDLE;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // State update and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (next_state == DONE) 
                done <= 1;
            else 
                done <= 0;
        end
    end

endmodule