module TopModule (
    input logic a,   // Input a
    input logic b,   // Input b
    input logic c,   // Input c
    input logic d,   // Input d
    output logic out // Output out
);

    // Combinational logic based on the Karnaugh map
    always @(*) begin
        out = (c == 1'b0 && d == 1'b0 && b == 1'b1) ||  // cd = 00, ab = 01
              (c == 1'b0 && d == 1'b1 && a == 1'b1) ||  // cd = 01, ab = 10
              (c == 1'b1 && d == 1'b0 && a == 1'b1) ||  // cd = 10, ab = 10
              (c == 1'b1 && d == 1'b1 && b == 1'b1) ||  // cd = 11, ab = 01
              (c == 1'b1 && d == 1'b0 && b == 1'b1) ||  // cd = 10, ab = 11
              (c == 1'b0 && d == 1'b1 && b == 1'b0);    // cd = 01, ab = 00
    end

endmodule