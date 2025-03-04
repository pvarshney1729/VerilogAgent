module TopModule(
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Default all outputs to 0
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;
    
    // Check scancode and set the appropriate output
    case (scancode)
        16'hE06B: left = 1'b1;
        16'hE072: down = 1'b1;
        16'hE074: right = 1'b1;
        16'hE075: up = 1'b1;
        default: ; // No action needed, outputs are already set to 0
    endcase
end

endmodule