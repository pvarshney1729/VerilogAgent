```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        RECEIVE = 3'b001,
        VERIFY_STOP = 3'b010,
        DONE = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_count;
    logic [7:0] data_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                data_reg <= {in, data_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == DONE) begin
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
                    next_state = VERIFY_STOP;
                end
            end
            VERIFY_STOP: begin
                if (in == 1'b1) begin
                    next_state = DONE;
                end else begin
                    next_state = ERROR;
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```