[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign out = (current_state == D) ? 1'b1 : 1'b0;

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
```
[DONE]