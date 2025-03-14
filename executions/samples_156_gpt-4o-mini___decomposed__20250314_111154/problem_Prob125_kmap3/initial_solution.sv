module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

assign out = (a == 1'b0 && b == 1'b0 && c == 1'b0) ? 1'b0 : // cd = 00, ab = 00
             (a == 1'b0 && b == 1'b0 && c == 1'b1) ? 1'b1 : // cd = 01, ab = 00
             (a == 1'b0 && b == 1'b1 && c == 1'b0) ? 1'b0 : // cd = 00, ab = 01
             (a == 1'b0 && b == 1'b1 && c == 1'b1) ? 1'b1 : // cd = 01, ab = 01
             (a == 1'b1 && b == 0 && c == 1'b0) ? 1'b1 : // cd = 00, ab = 10
             (a == 1'b1 && b == 0 && c == 1'b1) ? 1'b1 : // cd = 01, ab = 10
             (a == 1'b1 && b == 1 && c == 1'b0) ? 1'b1 : // cd = 00, ab = 11
             (a == 1'b1 && b == 1 && c == 1'b1) ? 1'b1 : // cd = 01, ab = 11
             1'b0; // Default case, can choose any value for don't-care

endmodule