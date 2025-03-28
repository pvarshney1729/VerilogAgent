module TopModule (
    input  logic clk,
    input  logic in,
    input  logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_buffer;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_buffer <= 8'b00000000;
            bit_count <= 3'b000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                data_buffer <= {in, data_buffer[7:1]}; // Shift in the data bits
            end
            if (next_state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 3'b000; // Reset bit count
            end
            DATA_BITS: begin
                if (bit_count == 3'b111) begin // 8 bits received
                    next_state = STOP_BIT;
                end else begin
                    bit_count = bit_count + 3'b001; // Count the bits
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Stop bit detected
                    out_byte = data_buffer; // Output the received byte
                    next_state = DONE;
                end else begin
                    next_state = IDLE; // Wait for a valid stop bit
                end
            end
            DONE: begin
                next_state = IDLE; // After done, return to IDLE
            end
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly