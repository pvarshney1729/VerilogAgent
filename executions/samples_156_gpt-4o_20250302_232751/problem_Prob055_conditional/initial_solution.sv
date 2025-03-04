module TopModule (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always @(*) begin
    if (a <= b && a <= c && a <= d)
        min = a;
    else if (b <= a && b <= c && b <= d)
        min = b;
    else if (c <= a && c <= b && c <= d)
        min = c;
    else
        min = d;
end

endmodule