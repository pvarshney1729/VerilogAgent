module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1_RECEIVED = 2'b01,
        BYTE2_RECEIVED = 2'b10,
        BYTE3_RECEIVED = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and done signal
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1_RECEIVED;
                end
            end
            BYTE1_RECEIVED: begin
                next_state = BYTE2_RECEIVED;
            end
            BYTE2_RECEIVED: begin
                next_state = BYTE3_RECEIVED;
            end
            BYTE3_RECEIVED: begin
                done = 1'b1; // Signal done after receiving third byte
                next_state = IDLE; // Go back to IDLE to await next message
            end
            default: begin
                next_state = IDLE; // Fallback to IDLE state
            end
        endcase
    end

endmodule