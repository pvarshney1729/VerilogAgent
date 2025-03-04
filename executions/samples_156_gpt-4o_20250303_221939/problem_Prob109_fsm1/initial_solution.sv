```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State Encoding
    typedef enum logic {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B; // Default to state B
        endcase
    end

    // Sequential Logic with Asynchronous Reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Asynchronously reset to state B
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1; // Default to state B's output
        endcase
    end

endmodule
```