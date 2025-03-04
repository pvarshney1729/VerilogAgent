```verilog
module serial_receiver (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        DATA_RECEPTION = 2'b01,
        STOP_BIT_VERIFICATION = 2'b10,
        OUTPUT_VALID = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            shift_reg <= 8'b00000000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA_RECEPTION) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == OUTPUT_VALID) begin
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
                if (in == 1'b0) begin
                    next_state = DATA_RECEPTION;
                end
            end
            DATA_RECEPTION: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP_BIT_VERIFICATION;
                end
            end
            STOP_BIT_VERIFICATION: begin
                if (in == 1'b1) begin
                    next_state = OUTPUT_VALID;
                end else begin
                    next_state = IDLE;
                end
            end
            OUTPUT_VALID: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```