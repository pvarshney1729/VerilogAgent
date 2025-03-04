module TopModule(
    input [3:0] x,
    output logic f
);

    always @(*) begin
        case (x)
            4'b0000, 4'b0011, 4'b1100, 4'b1101, 
            4'b1110, 4'b1000, 4'b1001, 4'b1011: f = 1'b1;
            default: f = 1'b0;
        endcase
    end

endmodule