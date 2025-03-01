module TopModule (
    input logic clk,         // Clock signal, triggers all sequential logic on the positive edge
    input logic in,          // Serial data input, receives the bit stream
    input logic reset,       // Active-high synchronous reset signal
    output logic [7:0] out_byte,  // 8-bit output representing the received data byte
    output logic done        // Output signal asserted when a valid byte is received
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        RECEIVE = 3'b001,
        VERIFY = 3'b010,
        OUTPUT = 3'b011,
        ERROR_RECOVERY = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 1'b0;
            bit_count <= 3'b0;
            shift_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == OUTPUT) begin
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
                    next_state = RECEIVE;
                end
            end
            RECEIVE: begin
                if (bit_count == 3'b111) begin
                    next_state = VERIFY;
                end
            end
            VERIFY: begin
                if (in == 1'b1) begin
                    next_state = OUTPUT;
                end else begin
                    next_state = ERROR_RECOVERY;
                end
            end
            OUTPUT: begin
                next_state = IDLE;
            end
            ERROR_RECOVERY: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule