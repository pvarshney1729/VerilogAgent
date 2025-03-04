```verilog
module TopModule(
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    localparam state_A = 1'b0;
    localparam state_B = 1'b1;

    logic current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= state_B; // Asynchronous reset to state B
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            state_A: next_state = (in == 1'b0) ? state_B : state_A;
            state_B: next_state = (in == 1'b0) ? state_A : state_B;
            default: next_state = state_B; // Default to state B
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            state_A: out = 1'b0;
            state_B: out = 1'b1;
            default: out = 1'b1; // Default output
        endcase
    end

endmodule
```