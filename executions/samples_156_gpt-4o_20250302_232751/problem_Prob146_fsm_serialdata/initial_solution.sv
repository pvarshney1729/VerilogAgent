module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVE = 2'b01,
        VERIFY_STOP = 2'b10,
        VALID_BYTE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    // State Register
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
            if (current_state == VALID_BYTE) begin
                out_byte <= shift_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next State Logic
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
                    next_state = VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
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