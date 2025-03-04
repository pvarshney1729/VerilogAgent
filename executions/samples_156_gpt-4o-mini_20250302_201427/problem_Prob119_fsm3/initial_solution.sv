```verilog
module TopModule (
    logic clk,
    logic areset,
    logic in,
    logic out
);

    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    logic [1:0] state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // Default case for safety
        endcase
    end

    // Sequential logic
    always @(posedge clk) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A, B, C: out = 0;
            D: out = 1;
            default: out = 0; // Default case for safety
        endcase
    end

endmodule
```