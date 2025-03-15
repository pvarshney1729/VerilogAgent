[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        FIRST_BYTE,
        SECOND_BYTE,
        THIRD_BYTE
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 2'b00;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == IDLE && next_state == FIRST_BYTE) begin
                byte_count <= 2'b01;
            end else if (current_state == FIRST_BYTE && next_state == SECOND_BYTE) begin
                byte_count <= 2'b10;
            end else if (current_state == SECOND_BYTE && next_state == THIRD_BYTE) begin
                byte_count <= 2'b11;
            end else if (current_state == THIRD_BYTE && next_state == IDLE) begin
                byte_count <= 2'b00;
                done <= 1'b1; // Signal done after receiving the third byte
            end else begin
                done <= 1'b0; // Reset done in other states
            end
        end
    end

    always @(*) begin
        next_state = current_state; // Default next state
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = FIRST_BYTE;
                end
            end
            FIRST_BYTE: begin
                next_state = SECOND_BYTE;
            end
            SECOND_BYTE: begin
                next_state = THIRD_BYTE;
            end
            THIRD_BYTE: begin
                next_state = IDLE; // Go back to IDLE after third byte
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```
[DONE]