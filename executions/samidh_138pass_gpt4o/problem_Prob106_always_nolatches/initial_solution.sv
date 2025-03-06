[BEGIN]
```verilog
module TopModule(
    input [15:0] scancode,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

always @(*) begin
    // Default all outputs to 0
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    // Determine which key is pressed based on scancode
    case (scancode)
        16'hE06B: left = 1'b1;  // Left arrow key
        16'hE072: down = 1'b1;  // Down arrow key
        16'hE074: right = 1'b1; // Right arrow key
        16'hE075: up = 1'b1;    // Up arrow key
        default: ;              // No action needed, outputs remain 0
    endcase
end

endmodule
```
[DONE]