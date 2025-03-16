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
        B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (in == 1'b0) ? B : A;
            B: next_state = (in == 1'b0) ? A : B;
            default: next_state = B; // Default to state B
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= B; // Reset to state B
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic (Moore machine output)
    assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
```
[DONE]