```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B; // Default to state B
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= B;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1; // Default to output of state B
        endcase
    end

endmodule
```