module TopModule (
    input [15:0] scancode,  // 16-bit input representing PS/2 keyboard scancode
    output logic left,      // 1-bit output, asserted when left arrow key is detected
    output logic down,      // 1-bit output, asserted when down arrow key is detected
    output logic right,     // 1-bit output, asserted when right arrow key is detected
    output logic up         // 1-bit output, asserted when up arrow key is detected
);

always @(*) begin
    // Default all outputs to 0
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    // Check scancode and set corresponding output
    case (scancode)
        16'he06b: left = 1'b1;
        16'he072: down = 1'b1;
        16'he074: right = 1'b1;
        16'he075: up = 1'b1;
        default: ; // All outputs remain de-asserted
    endcase
end

endmodule