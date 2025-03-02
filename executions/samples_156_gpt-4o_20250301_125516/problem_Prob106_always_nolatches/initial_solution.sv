```verilog
module TopModule (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        // Initialize outputs to 0
        left = 0;
        down = 0;
        right = 0;
        up = 0;

        // Decode scancode
        case (scancode)
            16'hE06B: left  = 1;
            16'hE072: down  = 1;
            16'hE074: right = 1;
            16'hE075: up    = 1;
            default: ; // All outputs remain 0
        endcase
    end

endmodule
```