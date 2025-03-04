module TopModule (
    input logic clk,            // Clock input, positive edge-triggered
    input logic reset,          // Active-high synchronous reset
    input logic in,             // Serial input bit stream
    output logic done           // Active-high output, indicates byte received correctly
);

    typedef enum logic [1:0] {
        IDLE,
        RECEIVE,
        VERIFY_STOP,
        ERROR
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data;           // To store received data
    logic [2:0] bit_count;      // To count received bits

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to hold current state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = RECEIVE;
                end
            end
            RECEIVE: begin
                if (bit_count == 3'b111) begin // 8 bits received
                    next_state = VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                if (in == 1'b1) begin // Stop bit correct
                    next_state = IDLE;
                end else begin // Stop bit incorrect
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin // Correct stop bit detected
                    next_state = IDLE;
                end
            end
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == IDLE && next_state == RECEIVE) begin
                bit_count <= 3'b000; // Reset bit count on start
            end else if (current_state == RECEIVE) begin
                bit_count <= bit_count + 1; // Increment bit count
            end else if (current_state == VERIFY_STOP && next_state == IDLE) begin
                done <= 1'b1; // Set done signal
            end else begin
                done <= 1'b0; // Reset done signal
            end
        end
    end

endmodule