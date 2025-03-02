module byte_receiver (
    input logic clk,
    input logic reset,
    input logic byte_valid,
    input logic [7:0] byte_in,
    output logic done,
    output logic [23:0] data_out
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE_BYTE1,
        RECEIVE_BYTE2,
        RECEIVE_BYTE3,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [23:0] data_reg;
    logic [2:0] byte_count;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_reg <= 24'b0;
            byte_count <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_BYTE1 || current_state == RECEIVE_BYTE2 || current_state == RECEIVE_BYTE3) begin
                data_reg <= {data_reg[15:0], byte_in}; // Shift in the new byte
                byte_count <= byte_count + 3'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (byte_valid) begin
                    next_state = RECEIVE_BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE_BYTE1: begin
                if (byte_valid) begin
                    next_state = RECEIVE_BYTE2;
                end else begin
                    next_state = RECEIVE_BYTE1;
                end
            end
            RECEIVE_BYTE2: begin
                if (byte_valid) begin
                    next_state = RECEIVE_BYTE3;
                end else begin
                    next_state = RECEIVE_BYTE2;
                end
            end
            RECEIVE_BYTE3: begin
                next_state = DONE; // Move to DONE after receiving the third byte
            end
            DONE: begin
                next_state = DONE; // Stay in DONE state
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign done = (current_state == DONE);
    assign data_out = data_reg;

endmodule