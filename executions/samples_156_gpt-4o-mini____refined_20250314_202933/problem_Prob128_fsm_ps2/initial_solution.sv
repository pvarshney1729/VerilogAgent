[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVING = 2'b01
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
            if (next_state == RECEIVING) begin
                byte_count <= byte_count + 2'b01;
            end
            if (byte_count == 2'b10) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = current_state; // Default to current state
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVING;
                    byte_count = 2'b00; // Reset byte_count on new message
                end
            end
            RECEIVING: begin
                if (byte_count == 2'b10) begin
                    next_state = IDLE; // Transition back to IDLE after receiving 3 bytes
                end
            end
        endcase
    end

endmodule
```
[DONE]