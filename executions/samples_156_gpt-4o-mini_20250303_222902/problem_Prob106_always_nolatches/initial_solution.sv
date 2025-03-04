module TopModule (
    input [15:0] scancode,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

always @(*) begin
    // Default all outputs to low
    left = 0;
    down = 0;
    right = 0;
    up = 0;
    
    // Check scancode and set appropriate output high
    case (scancode)
        16'hE06B: left = 1;
        16'hE072: down = 1;
        16'hE074: right = 1;
        16'hE075: up = 1;
        default: ; // All outputs remain low
    endcase
end

endmodule