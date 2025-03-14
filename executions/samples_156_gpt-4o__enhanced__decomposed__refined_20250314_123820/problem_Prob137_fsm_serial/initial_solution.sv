[BEGIN]
module TopModule (
    input logic clk,             // Clock signal, positive edge-triggered
    input logic reset,           // Active-high synchronous reset
    input logic in,              // Serial data input
    output logic done            // Output signal, high when a correct byte is received
);

    // State declaration for the FSM
    typedef enum logic [2:0] {
        IDLE  = 3'b000,  // Waiting for a start bit
        START = 3'b001,  // Start bit detected
        DATA  = 3'b010,  // Collecting data bits
        STOP  = 3'b011,  // Verifying stop bit
        ERROR = 3'b100   // Incorrect stop bit detected
    } state_t;

    state_t state, next_state;
    logic [3:0] bit_count;
    logic [7:0] data_byte;

    // Initialize FSM state and done signal on reset
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            bit_count <= 4'b0000;
            data_byte <= 8'b00000000;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                data_byte[bit_count] <= in;
                bit_count <= bit_count + 1'b1;
            end
        end
    end

    // State transition logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
                bit_count = 4'b0000;
            end
            DATA: begin
                if (bit_count == 4'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    done = 1'b1;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
[DONE]