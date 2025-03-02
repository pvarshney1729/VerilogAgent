```verilog
module moore_fsm (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_0: next_state = in ? STATE_1 : STATE_0;
            STATE_1: next_state = in ? STATE_1 : STATE_0;
            default: next_state = STATE_0;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_0: out = 1'b0;
            STATE_1: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
```