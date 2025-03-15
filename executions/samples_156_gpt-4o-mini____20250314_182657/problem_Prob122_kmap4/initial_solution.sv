module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (c == 1'b0 && d == 1'b0 && b == 1'b0) || // cd = 00
              (c == 1'b0 && d == 1'b1 && b == 1'b0) || // cd = 01
              (c == 1'b1 && d == 1'b0 && b == 1'b1) || // cd = 10
              (c == 1'b1 && d == 1'b1 && b == 1'b0) || // cd = 11
              (c == 1'b0 && d == 1'b0 && b == 1'b1) || // cd = 00
              (c == 1'b1 && d == 1'b0 && b == 1'b0) || // cd = 10
              (c == 1'b0 && d == 1'b1 && b == 1'b1) || // cd = 01
              (c == 1'b1 && d == 1'b1 && b == 1'b1);   // cd = 11
    end

endmodule