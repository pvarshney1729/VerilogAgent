module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    assign q = (a == 1'b0 && b == 1'b0 && c == 1'b1) || 
               (a == 1'b0 && b == 1'b0 && d == 1'b1) || 
               (a == 1'b0 && b == 1'b1) || 
               (a == 1'b1 && b == 1'b0 && c == 1'b1) || 
               (a == 1'b1 && b == 1'b1);

endmodule