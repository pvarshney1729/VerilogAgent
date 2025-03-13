```verilog
[BEGIN]
module TopModule (
    input  logic clk,     // Clock signal; positive-edge triggered
    input  logic areset,  // Asynchronous reset; active high
    input  logic x,       // Serial input bit; unsigned
    output logic z        // Serial output bit; unsigned
);

    typedef enum logic [1:0] {
        STATE_IDLE = 2'b00,
        STATE_NEGATE = 2'b01,
        STATE_PASS = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic negate;

    // State transition logic
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_IDLE;
            negate <= 1'b0;
        end else begin
            current_state <= next_state;
            negate <= (next_state == STATE_NEGATE) ? 1'b1 : 1'b0;
        end
    end

    // Next state logic
    always_ff @(current_state, x) begin
        case (current_state)
            STATE_IDLE: begin
                next_state <= (x == 1'b1) ? STATE_NEGATE : STATE_PASS;
            end
            STATE_NEGATE: begin
                next_state <= STATE_PASS;
            end
            STATE_PASS: begin
                next_state <= STATE_PASS;
            end
            default: begin
                next_state <= STATE_IDLE;
            end
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_IDLE: z = 1'b0;
            STATE_NEGATE: z = ~x;
            STATE_PASS: z = x;
            default: z = 1'b0;
        endcase
    end

endmodule
[DONE]
```