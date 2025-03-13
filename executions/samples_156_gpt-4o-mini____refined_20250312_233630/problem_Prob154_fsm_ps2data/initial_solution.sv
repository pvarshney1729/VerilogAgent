[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        WAIT_FOR_FIRST_BYTE,
        RECEIVE_BYTES,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [23:0] byte_buffer;
    logic [1:0] byte_count;

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to current state
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_FIRST_BYTE;
                end
            end
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTES;
                end
            end
            RECEIVE_BYTES: begin
                if (byte_count == 2'b10) begin
                    next_state = DONE_STATE;
                end
            end
            DONE_STATE: begin
                next_state = WAIT_FOR_FIRST_BYTE;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 2'b00;
            byte_buffer <= 24'b0;
            done <= 1'b0;
            out_bytes <= 24'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                WAIT_FOR_FIRST_BYTE: begin
                    // Do nothing
                end
                RECEIVE_BYTES: begin
                    byte_buffer <= {byte_buffer[15:0], in};
                    byte_count <= byte_count + 1'b1;
                end
                DONE_STATE: begin
                    done <= 1'b1;
                    out_bytes <= byte_buffer;
                end
                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
```
[DONE]