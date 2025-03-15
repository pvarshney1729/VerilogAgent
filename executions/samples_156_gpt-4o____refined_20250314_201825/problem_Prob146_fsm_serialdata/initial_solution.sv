[BEGIN]
module TopModule (
    input logic clk,
    input logic in,
    input logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            data_reg <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 3'd1;
            end
            if (current_state == STOP) begin
                out_byte <= data_reg;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = STOP;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]