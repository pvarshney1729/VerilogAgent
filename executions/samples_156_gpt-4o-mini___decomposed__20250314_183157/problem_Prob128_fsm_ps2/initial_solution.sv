module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10,
        MESSAGE_COMPLETE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            byte_count <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        done = 1'b0; // Default done signal
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1_RECEIVED;
                    byte_count = 2'b01; // Start counting bytes
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1_RECEIVED: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1_RECEIVED; // Stay in this state for valid byte
                end else begin
                    next_state = BYTE2_RECEIVED;
                    byte_count = 2'b10; // Second byte received
                end
            end
            BYTE2_RECEIVED: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1_RECEIVED; // Reset to first byte
                    byte_count = 2'b01; // Start counting bytes again
                end else begin
                    next_state = MESSAGE_COMPLETE;
                    done = 1'b1; // Signal done after receiving 3 bytes
                end
            end
            MESSAGE_COMPLETE: begin
                next_state = IDLE; // Go back to idle after completing message
            end
            default: next_state = IDLE; // Default state
        endcase
    end
endmodule