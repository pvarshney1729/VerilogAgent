module TopModule (
    input [3:0] x,
    output logic f
);
    assign f = (x[3:2] == 2'b00 && (x[1:0] == 2'b00 || x[1:0] == 2'b10)) ||
               (x[3:2] == 2'b11 && (x[1:0] == 2'b00 || x[1:0] == 2'b01 || x[1:0] == 2'b11)) ||
               (x[3:2] == 2'b10 && (x[1:0] == 2'b00 || x[1:0] == 2'b01 || x[1:0] == 2'b10));
endmodule