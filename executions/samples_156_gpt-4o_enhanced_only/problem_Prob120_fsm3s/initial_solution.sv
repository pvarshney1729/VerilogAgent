```verilog
module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;  // Synchronous reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;  // Default state
        endcase
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            A, B, C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0;  // Default output
        endcase
    end

endmodule
```