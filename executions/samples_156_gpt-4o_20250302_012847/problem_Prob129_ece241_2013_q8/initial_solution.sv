```verilog
module fsm_with_active_low_reset (
    input logic clk,
    input logic reset_n,  // Active-low reset
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S2 : S0;
            S2: next_state = x ? S2 : S0;
            default: next_state = S0;
        endcase
    end

    // State register with synchronous active-low reset
    always @(posedge clk) begin
        if (!reset_n) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: z = 1'b0;
            S1: z = 1'b0;
            S2: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
```