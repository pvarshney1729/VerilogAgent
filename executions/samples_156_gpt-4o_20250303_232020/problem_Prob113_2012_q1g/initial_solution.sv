module TopModule(
    input [3:0] x,
    output reg f
);
    always @(*) begin
        case (x)
            4'b0000, 4'b1000, 4'b1010, 4'b1100, 4'b1101: f = 1;
            default: f = 0;
        endcase
    end
endmodule