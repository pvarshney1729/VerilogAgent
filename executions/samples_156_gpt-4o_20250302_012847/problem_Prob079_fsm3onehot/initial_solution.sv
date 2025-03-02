```verilog
module fsm_with_one_hot_checker (
    input logic clk,
    input logic reset,
    input logic [2:0] state_in,
    output logic [2:0] state_out
);

    // State encoding
    localparam logic [2:0] S0 = 3'b001,
                           S1 = 3'b010,
                           S2 = 3'b100;

    logic [2:0] current_state, next_state;

    // One-hot checker
    function logic is_one_hot(input logic [2:0] state);
        return (state == S0) || (state == S1) || (state == S2);
    endfunction

    // State transition logic with one-hot checking
    always @(*) begin
        if (!is_one_hot(current_state)) begin
            next_state = S0; // Reset to a valid state if invalid
        end else begin
            case (current_state)
                S0: next_state = S1;
                S1: next_state = S2;
                S2: next_state = S0;
                default: next_state = S0; // Default to a valid state
            endcase
        end
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign state_out = current_state;

endmodule
```