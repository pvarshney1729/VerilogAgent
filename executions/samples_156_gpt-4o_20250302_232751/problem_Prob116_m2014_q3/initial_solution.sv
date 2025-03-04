module TopModule(
    input [3:0] x,
    output reg f
);

    always @(*) begin
        case (x)
            4'b0110, 4'b0111, 4'b1100, 4'b1101, 4'b1110, 4'b1111: f = 1'b1;
            default: f = 1'b0;
        endcase
    end

endmodule