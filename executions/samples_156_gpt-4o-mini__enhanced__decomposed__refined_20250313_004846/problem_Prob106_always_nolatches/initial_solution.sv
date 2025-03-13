[BEGIN]
```verilog
module TopModule (
    input [15:0] scancode,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

always @(*) begin
    // Default state for all outputs
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    case (scancode)
        16'he06b: left = 1'b1;  // left arrow
        16'he072: down = 1'b1;  // down arrow
        16'he074: right = 1'b1; // right arrow
        16'he075: up = 1'b1;    // up arrow
        default: ;              // All outputs remain low
    endcase
end

endmodule
```
[DONE]