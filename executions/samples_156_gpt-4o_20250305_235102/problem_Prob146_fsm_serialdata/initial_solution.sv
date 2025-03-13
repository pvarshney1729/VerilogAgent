```verilog
[BEGIN]
module TopModule (
    input  logic clk,          // Clock signal
    input  logic in,           // Serial data input
    input  logic reset,        // Active-high synchronous reset
    output logic [7:0] out_byte, // 8-bit data output
    output logic done           // Data valid signal
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        RECEIVE_START = 3'b001,
        RECEIVE_DATA = 3'b010,
        CHECK_STOP = 3'b011,
        VALID_BYTE = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    // State register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_count <= 3'b000;
            shift_reg <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_DATA) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 3'b001;
            end
            if (current_state == VALID_BYTE) begin
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
                    next_state = RECEIVE_START;
                end
            end
            RECEIVE_START: begin
                next_state = RECEIVE_DATA;
            end
            RECEIVE_DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = CHECK_STOP;
                end
            end
            CHECK_STOP: begin
                if (in == 1'b1) begin
                    next_state = VALID_BYTE;
                end else begin
                    next_state = IDLE;
                end
            end
            VALID_BYTE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]
```