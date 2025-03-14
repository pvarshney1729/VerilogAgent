module TopModule (
    input logic [3:0] x,
    input logic reset,
    output logic f
);

always @(*) begin
    if (reset) begin
        f = 1'b0;
    end else begin
        case (x)
            4'b0000: f = 1'b0; // d
            4'b0001: f = 1'b0; // 0
            4'b0010: f = 1'b0; // d
            4'b0011: f = 1'b1; // 1
            4'b0100: f = 1'b0; // 0
            4'b0101: f = 1'b1; // d
            4'b0110: f = 1'b1; // 1
            4'b0111: f = 1'b1; // d
            4'b1000: f = 1'b1; // 1
            4'b1001: f = 1'b1; // 1
            4'b1010: f = 1'b0; // 0
            4'b1011: f = 1'b0; // d
            4'b1100: f = 1'b0; // d
            4'b1101: f = 1'b0; // d
            4'b1110: f = 1'b0; // d
            4'b1111: f = 1'b0; // d
            default: f = 1'b0; // default case
        endcase
    end
end

endmodule