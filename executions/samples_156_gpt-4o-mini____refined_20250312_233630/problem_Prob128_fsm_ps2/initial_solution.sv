[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            done <= (current_state == BYTE3); // Signal done after receiving 3 bytes
        end
    end

    always @(*) begin
        next_state = current_state; // Default next state
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE; // Go back to IDLE after done
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```
[DONE]