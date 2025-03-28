```verilog
module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    logic [23:0] message_buffer;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            message_buffer <= 24'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 1'b0;
        out_bytes = 24'bx;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                    message_buffer[23:16] = in;
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;
                message_buffer[15:8] = in;
            end
            
            BYTE2: begin
                next_state = BYTE3;
                message_buffer[7:0] = in;
            end
            
            BYTE3: begin
                done = 1'b1;
                out_bytes = message_buffer;
                next_state = IDLE; // Return to IDLE after message completion
            end
        endcase
    end

endmodule
```