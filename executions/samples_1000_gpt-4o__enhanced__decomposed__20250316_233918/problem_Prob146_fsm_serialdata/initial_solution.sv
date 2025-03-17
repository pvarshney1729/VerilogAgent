module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [7:0] shift_reg;
    logic [3:0] bit_count;

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 4'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state; // Default to hold state
        done = 1'b0; // Default done signal
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
                bit_count = 4'b0;
            end
            DATA: begin
                shift_reg = {in, shift_reg[7:1]}; // Shift in LSB first
                bit_count = bit_count + 1;
                if (bit_count == 4'd7) // After 8 data bits
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin // Check stop bit
                    done = 1'b1;
                    out_byte = shift_reg;
                end
                next_state = IDLE;
            end
            default: next_state = IDLE; // Default case
        endcase
    end

endmodule