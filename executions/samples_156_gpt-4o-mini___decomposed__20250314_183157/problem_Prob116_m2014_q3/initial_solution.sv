module TopModule (
    input logic [3:0] x,
    output logic f
);
    assign f = (x[3:0] == 4'b0011) || // x[3:4] = 11, x[1:2] = 00
               (x[3:0] == 4'b0110) || // x[3:4] = 01, x[1:2] = 11
               (x[3:0] == 4'b0010) || // x[3:4] = 10, x[1:2] = 00
               (x[3:0] == 4'b0000) || // x[3:4] = 00, x[1:2] = 00
               1'b0; // default case (for don't-care conditions)
endmodule