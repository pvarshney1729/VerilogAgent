module fsm_capture_bytes (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        CAPTURE,
        DONE_STATE
    } state_t;

    state_t current_state, next_state;
    logic [23:0] byte_buffer;
    logic [1:0] byte_count;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_buffer <= 24'b0;
            byte_count <= 2'b0;
        end else begin
            current_state <= next_state;
            if (current_state == CAPTURE) begin
                byte_buffer <= {byte_buffer[15:0], in};
                byte_count <= byte_count + 2'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (byte_count < 2'b11) begin
                    next_state = CAPTURE;
                end else begin
                    next_state = DONE_STATE;
                end
            end
            CAPTURE: begin
                if (byte_count == 2'b10) begin
                    next_state = DONE_STATE;
                end else begin
                    next_state = CAPTURE;
                end
            end
            DONE_STATE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign out_bytes = (current_state == DONE_STATE) ? byte_buffer : 24'b0;
    assign done = (current_state == DONE_STATE);

endmodule