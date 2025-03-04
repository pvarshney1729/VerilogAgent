```verilog
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
        VERIFY = 2'b10,
        COMPLETE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'hXX;
            done <= 1'b0;
            bit_count <= 3'b000;
            shift_reg <= 8'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin
                        next_state <= RECEIVE;
                        bit_count <= 3'b000;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                RECEIVE: begin
                    shift_reg <= {in, shift_reg[7:1]};
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'b111) begin
                        next_state <= VERIFY;
                    end else begin
                        next_state <= RECEIVE;
                    end
                end
                VERIFY: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        next_state <= COMPLETE;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                COMPLETE: begin
                    done <= 1'b0;
                    next_state <= IDLE;
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule
```