```verilog
module fsm_monitor (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: next_state = w ? S1 : S0;
            S1: next_state = w ? S2 : S0;
            S2: next_state = w ? S3 : S0;
            S3: next_state = w ? S3 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            S3: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
```