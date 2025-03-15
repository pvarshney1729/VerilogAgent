module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

// State encoding
typedef enum logic [1:0] {
    IDLE,
    START,
    DATA,
    STOP
} state_t;

state_t current_state, next_state;
logic [3:0] bit_count;
logic [7:0] data_reg;

// Sequential logic for state transition
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        bit_count <= 0;
        out_byte <= 8'b0;
        done <= 1'b0;
    end else begin
        current_state <= next_state;
    end
end

// Combinational logic for state transitions and output generation
always @(*) begin
    next_state = current_state;
    done = 1'b0; // Default done signal
    case (current_state)
        IDLE: begin
            if (in == 1'b0) begin // Start bit detected
                next_state = START;
                bit_count = 0;
            end
        end
        START: begin
            next_state = DATA; // Move to data state after start bit
        end
        DATA: begin
            if (bit_count < 8) begin
                data_reg[bit_count] = in; // Capture data bit
                bit_count = bit_count + 1;
            end else begin
                next_state = STOP; // Move to stop state after collecting 8 bits
            end
        end
        STOP: begin
            if (in == 1'b1) begin // Stop bit detected
                done = 1'b1; // Data byte is valid
                out_byte = data_reg; // Output the received byte
                next_state = IDLE; // Return to idle state
            end else begin
                // Stay in STOP state until valid stop bit is detected
                next_state = STOP;
            end
        end
    endcase
end

endmodule