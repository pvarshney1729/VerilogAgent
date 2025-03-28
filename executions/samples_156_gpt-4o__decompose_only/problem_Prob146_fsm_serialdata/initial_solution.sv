module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        START = 3'b001,
        DATA  = 3'b010,
        STOP  = 3'b011,
        DONE  = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count; // To count the 8 data bits
    logic [7:0] data_buffer;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_buffer <= 8'b00000000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_buffer[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            if (current_state == DONE) begin
                out_byte <= data_buffer;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111) // All 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Detect stop bit
                    next_state = DONE;
                else
                    next_state = IDLE; // Error, go back to IDLE
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule