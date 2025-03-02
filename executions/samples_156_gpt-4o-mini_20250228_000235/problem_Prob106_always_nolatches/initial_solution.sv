module TopModule (
    input logic [15:0] scancode,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

    always @(*) begin
        left = 1'b0;
        down = 1'b0;
        right = 1'b0;
        up = 1'b0;

        case (scancode)
            16'hE06B: left = 1'b1;   // left arrow
            16'hE072: down = 1'b1;   // down arrow
            16'hE074: right = 1'b1;  // right arrow
            16'hE075: up = 1'b1;      // up arrow
            default: ;                 // none
        endcase
    end

endmodule