module TopModule (
    input [15:0] scancode,  // 16-bit input representing the scancode from the PS/2 keyboard
    output reg left,        // 1-bit output, asserted when left arrow key is detected
    output reg down,        // 1-bit output, asserted when down arrow key is detected
    output reg right,       // 1-bit output, asserted when right arrow key is detected
    output reg up           // 1-bit output, asserted when up arrow key is detected
);

always @(*) begin
    // Default de-assert all outputs
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;
    
    case (scancode)
        16'he06b: left = 1'b1;
        16'he072: down = 1'b1;
        16'he074: right = 1'b1;
        16'he075: up = 1'b1;
        default: ; // Implicitly handles all other cases by de-asserting outputs
    endcase
end

endmodule