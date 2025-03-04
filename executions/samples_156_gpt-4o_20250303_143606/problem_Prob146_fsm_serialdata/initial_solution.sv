module TopModule (
    input logic clk,                  // Clock signal, positive edge triggered
    input logic in,                   // Serial input bit stream
    input logic reset,                // Active-high synchronous reset
    output logic [7:0] out_byte,      // 8-bit output data byte
    output logic done                 // Output signal indicating a valid byte
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVING = 2'b01,
        VERIFY = 2'b10,
        COMPLETE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter;
    logic [7:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_counter <= 3'b0;
            shift_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVING) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_counter <= bit_counter + 1;
            end
            if (current_state == COMPLETE) begin
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
                if (in == 1'b0) begin
                    next_state = RECEIVING;
                end
            end
            RECEIVING: begin
                if (bit_counter == 3'b111) begin
                    next_state = VERIFY;
                end
            end
            VERIFY: begin
                if (in == 1'b1) begin
                    next_state = COMPLETE;
                end else begin
                    next_state = IDLE;
                end
            end
            COMPLETE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule