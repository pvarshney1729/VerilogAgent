```
[BEGIN]
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
    logic [2:0] byte_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 3'b000;
            byte_buffer <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_ff @(current_state, in, byte_count) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTES;
                    byte_buffer = {16'b0, in}; // Start with first byte
                    byte_count = 3'b001;
                end
            end

            RECEIVE_BYTES: begin
                if (byte_count < 3'b011) begin
                    byte_buffer <= {byte_buffer[15:0], in};
                    byte_count <= byte_count + 3'b001;
                end
                if (byte_count == 3'b011) begin
                    next_state = DONE_STATE;
                end
            end

            DONE_STATE: begin
                done = 1'b1;
                next_state = IDLE; // Go back to IDLE after signaling done
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else if (done) begin
            out_bytes <= byte_buffer;
        end
    end

endmodule
[DONE]
```