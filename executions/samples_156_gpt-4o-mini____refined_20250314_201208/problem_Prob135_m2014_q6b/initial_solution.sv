[BEGIN]
```verilog
module TopModule (
    input logic [2:0] y,
    input logic w,
    output logic Y1
);

    logic [2:0] next_state;

    // Next-state logic for y[1]
    always @(*) begin
        case (y)
            3'b000: next_state = (w) ? 3'b000 : 3'b001; // A
            3'b001: next_state = (w) ? 3'b010 : 3'b011; // B
            3'b010: next_state = (w) ? 3'b100 : 3'b011; // C
            3'b011: next_state = (w) ? 3'b000 : 3'b101; // D
            3'b100: next_state = (w) ? 3'b100 : 3'b011; // E
            3'b101: next_state = (w) ? 3'b010 : 3'b011; // F
            default: next_state = 3'b000; // Default to state A
        endcase
    end

    // Output logic
    assign Y1 = y[1];

endmodule
```
[DONE]