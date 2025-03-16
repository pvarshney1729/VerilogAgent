module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (c == 1'b0 && d == 1'b0 && b == 1'b0 && a == 1'b1) || // 01
              (c == 1'b0 && d == 1'b1 && b == 1'b0 && a == 1'b1) || // 10
              (c == 1'b1 && d == 1'b0 && b == 1'b1 && a == 1'b0) || // 01
              (c == 1'b1 && d == 1'b1 && b == 1'b0 && a == 1'b1) || // 10
              (c == 1'b0 && d == 1'b0 && b == 1'b1 && a == 1'b0) || // 01
              (c == 1'b1 && d == 1'b0 && b == 1'b1 && a == 1'b1);   // 10
    end

endmodule