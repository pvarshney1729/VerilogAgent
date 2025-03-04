module TopModule (
    input  logic [7:0] a,  // 8-bit unsigned input
    input  logic [7:0] b,  // 8-bit unsigned input
    input  logic [7:0] c,  // 8-bit unsigned input
    input  logic [7:0] d,  // 8-bit unsigned input
    output logic [7:0] min // 8-bit unsigned output representing the minimum value
);

    always @(*) begin
        if (a <= b && a <= c && a <= d) begin
            min = a;
        end else if (b <= a && b <= c && b <= d) begin
            min = b;
        end else if (c <= a && c <= b && c <= d) begin
            min = c;
        end else begin
            min = d;
        end
    end

endmodule