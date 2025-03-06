```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic done_reg;

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to hold the current state
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) 
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            current_state <= IDLE;
        else 
            current_state <= next_state;
    end

    // Done signal generation
    always @(posedge clk) begin
        if (reset) 
            done_reg <= 1'b0;
        else if (current_state == BYTE3) 
            done_reg <= 1'b1;
        else 
            done_reg <= 1'b0;
    end

    assign done = done_reg;

endmodule
[DONE]
```