module TopModule(
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE       = 3'b000,
        START_BIT  = 3'b001,
        DATA_BITS  = 3'b010,
        STOP_BIT   = 3'b011,
        DONE_STATE = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count; // counts from 0 to 8 for data bits
    logic [7:0] data_bits; // to store the 8 data bits

    // Sequential block for state transitions and outputs
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0000;
            data_bits <= 8'b00000000;
            done <= 0;
            out_byte <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                data_bits <= {in, data_bits[7:1]}; // Shift in the data bits
                bit_count <= bit_count + 1;
            end
            if (current_state == DONE_STATE) begin
                out_byte <= data_bits;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Combinational block for next state logic
    always_comb begin
        next_state = current_state; // default state is to remain in current state
        case (current_state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 4'b0000; // Reset bit count
            end
            DATA_BITS: begin
                if (bit_count == 4'b1000) // 8 bits received
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1) // Stop bit detected
                    next_state = DONE_STATE;
                else
                    next_state = IDLE; // Incorrect stop bit, reset
            end
            DONE_STATE: begin
                next_state = IDLE; // Return to IDLE after acknowledging
            end
        endcase
    end

endmodule