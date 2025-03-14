[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 4'b1;
            end else if (current_state == IDLE) begin
                bit_count <= 4'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state <= START;
                end else begin
                    next_state <= IDLE;
                end
                done <= 1'b0;
            end
            START: begin
                next_state <= DATA;
                done <= 1'b0;
            end
            DATA: begin
                if (bit_count == 4'd7) begin
                    next_state <= STOP;
                end else begin
                    next_state <= DATA;
                end
                done <= 1'b0;
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state <= IDLE;
                    done <= 1'b1;
                end else begin
                    next_state <= STOP;
                    done <= 1'b0;
                end
            end
            default: begin
                next_state <= IDLE;
                done <= 1'b0;
            end
        endcase
    end

endmodule
```
[DONE]