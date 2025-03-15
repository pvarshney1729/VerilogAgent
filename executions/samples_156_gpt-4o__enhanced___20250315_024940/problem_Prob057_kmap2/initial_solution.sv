module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (a == 0 && b == 0 && c == 0 && d == 0) || // cd = 00, ab = 00
              (a == 0 && b == 0 && c == 0 && d == 1) || // cd = 01, ab = 00
              (a == 0 && b == 0 && c == 1 && d == 0) || // cd = 10, ab = 00
              (a == 0 && b == 1 && c == 0 && d == 0) || // cd = 00, ab = 01
              (a == 0 && b == 1 && c == 1 && d == 0) || // cd = 10, ab = 01
              (a == 1 && b == 0 && c == 0 && d == 1) || // cd = 01, ab = 10
              (a == 1 && b == 1 && c == 0 && d == 1) || // cd = 01, ab = 11
              (a == 1 && b == 0 && c == 0 && d == 0);   // cd = 00, ab = 10
    end
    
endmodule