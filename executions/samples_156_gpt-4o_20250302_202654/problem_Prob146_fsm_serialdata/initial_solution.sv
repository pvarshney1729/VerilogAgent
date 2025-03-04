module TopModule (
    input  logic        clk,        // Clock signal, positive edge-triggered
    input  logic        reset,      // Active-high synchronous reset
    input  logic        in,         // Serial data input
    output logic [7:0]  out_byte,   // 8-bit output data byte
    output logic        done        // Byte received indicator, 1-bit
);

    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT  = 3'b011,
        ERROR     = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_count <= 3'b000;
            shift_reg <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_BITS) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == STOP_BIT && in == 1'b1) begin
                out_byte <= shift_reg;
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
                if (in == 1'b0)
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_count == 3'b111)
                    next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule