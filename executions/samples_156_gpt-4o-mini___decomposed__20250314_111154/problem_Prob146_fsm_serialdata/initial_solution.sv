module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_count;
    logic [7:0] data_byte;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            data_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
                bit_count = 0;
            end
            DATA: begin
                if (bit_count < 4'd8) begin
                    data_byte[bit_count] = in; // Capture data bits
                    bit_count = bit_count + 1;
                    next_state = DATA;
                end else begin
                    next_state = STOP;
                end
            end
            STOP: begin
                done = 1'b1;
                if (in == 1'b1) // Stop bit detected
                    next_state = IDLE;
                else
                    next_state = STOP; // Wait for a valid stop bit
            end
            default: next_state = IDLE;
        endcase
    end

    assign out_byte = data_byte; // Output the received byte

endmodule