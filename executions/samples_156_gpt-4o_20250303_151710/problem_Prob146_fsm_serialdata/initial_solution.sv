module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic in,        // Serial data input
    input logic reset,     // Active-high, synchronous reset
    output logic [7:0] out_byte, // 8-bit output data byte, unsigned
    output logic done      // Indicates valid byte received, 1 bit wide
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        RECEIVE = 2'b01,
        VERIFY  = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count; // Counter for received bits
    logic [7:0] shift_reg; // Shift register for receiving bits

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_count <= 3'b000;
            shift_reg <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == DONE) begin
                out_byte <= shift_reg;
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
                    next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'b111) // 8 bits received
                    next_state = VERIFY;
            end
            VERIFY: begin
                if (in == 1'b1) // Stop bit correct
                    next_state = DONE;
                else
                    next_state = IDLE; // Incorrect stop bit, wait for next start bit
            end
            DONE: begin
                next_state = IDLE; // Return to IDLE after asserting done
            end
        endcase
    end

endmodule