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
    logic [2:0] bit_counter;
    logic [7:0] data_buffer;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            data_buffer <= 8'b00000000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_buffer[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
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
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'b111) // All 8 data bits received
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Stop bit detected
                    next_state = DONE;
                else
                    next_state = IDLE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule