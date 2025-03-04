```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_A,
        STATE_B
    } state_t;

    state_t current_state, next_state;
    logic [1:0] count_w;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            count_w <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (count_w < 2'b11) begin
                    count_w <= count_w + (w ? 1'b1 : 1'b0);
                end
                if (count_w == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (s) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
```