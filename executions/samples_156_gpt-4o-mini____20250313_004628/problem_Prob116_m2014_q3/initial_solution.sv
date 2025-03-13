module TopModule (
    input logic [3:0] x,
    output logic f
);

always @(*) begin
    case ({x[3], x[4], x[1], x[2]})
        4'b0000: f = 1'bx; // d
        4'b0001: f = 1'b0; 
        4'b0010: f = 1'bx; // d
        4'b0011: f = 1'bx; // d
        4'b0100: f = 1'b0; 
        4'b0101: f = 1'bx; // d
        4'b0110: f = 1'b1; 
        4'b0111: f = 1'b0; 
        4'b1000: f = 1'b1; 
        4'b1001: f = 1'b1; 
        4'b1010: f = 1'b0; 
        4'b1011: f = 1'bx; // d
        4'b1100: f = 1'bx; // d
        4'b1101: f = 1'bx; // d
        4'b1110: f = 1'bx; // d
        4'b1111: f = 1'bx; // d
        default: f = 1'b0; // Default case
    endcase
end

endmodule