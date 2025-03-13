[BEGIN]
module TopModule (
    input  logic [2:0] a,
    input  logic [2:0] b,
    output logic [2:0] out_or_bitwise,
    output logic out_or_logical,
    output logic [5:0] out_not
);

    // Compute bitwise OR
    assign out_or_bitwise = a | b;

    // Compute logical OR
    assign out_or_logical = |(a | b);

    // Compute NOT of a and b
    always @(*) begin
        out_not = {~b[2], ~b[1], ~b[0], ~a[2], ~a[1], ~a[0]};
    end

endmodule
[DONE]