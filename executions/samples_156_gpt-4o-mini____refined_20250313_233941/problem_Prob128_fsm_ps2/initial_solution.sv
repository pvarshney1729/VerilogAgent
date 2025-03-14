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
        WAIT_FOR_FIRST_BYTE,
        RECEIVE_SECOND_BYTE,
        RECEIVE_THIRD_BYTE
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 2'b00;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_THIRD_BYTE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                    byte_count = 2'b01;
                end
            end
            WAIT_FOR_FIRST_BYTE: begin
                if (byte_count == 2'b01) begin
                    next_state = RECEIVE_SECOND_BYTE;
                    byte_count = 2'b10;
                end
            end
            RECEIVE_SECOND_BYTE: begin
                if (byte_count == 2'b10) begin
                    next_state = RECEIVE_THIRD_BYTE;
                    byte_count = 2'b11;
                end
            end
            RECEIVE_THIRD_BYTE: begin
                if (byte_count == 2'b11) begin
                    next_state = IDLE;
                    byte_count = 2'b00;
                end
            end
        endcase
    end

endmodule
```
[DONE]