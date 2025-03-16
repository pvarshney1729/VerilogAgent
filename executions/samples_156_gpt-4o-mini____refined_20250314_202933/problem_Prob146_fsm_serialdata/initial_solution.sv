[BEGIN]
```verilog
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
    logic [7:0] data_reg;
    logic [2:0] bit_count;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_reg <= 8'b0;
            bit_count <= 3'b0;
            done <= 1'b0; // Ensure done is reset as well
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                data_reg[bit_count] <= in;
            end
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
                bit_count = 3'b0;
            end
            DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end else begin
                    bit_count = bit_count + 3'b1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = STOP;
                end
            end
        endcase
    end

    // Output assignment
    assign out_byte = (done) ? data_reg : 8'b0;

endmodule
```
[DONE]