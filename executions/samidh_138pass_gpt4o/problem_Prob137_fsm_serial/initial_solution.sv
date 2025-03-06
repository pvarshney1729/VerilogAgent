```verilog
module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVE = 2'b01,
        VERIFY = 2'b10,
        ERROR = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_reg;
    logic [3:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_reg <= 8'b0;
            bit_count <= 4'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                data_reg <= {in, data_reg[7:1]};
                bit_count <= bit_count + 1;
            end
            if (current_state == VERIFY) begin
                done <= (in == 1'b1);
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
                    next_state = RECEIVE;
                end
            end
            RECEIVE: begin
                if (bit_count == 4'd8) begin
                    next_state = VERIFY;
                end
            end
            VERIFY: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
```