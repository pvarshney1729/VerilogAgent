[BEGIN]
module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min
);

    always @(*) begin
        if (a <= b && a <= c && a <= d)
            min = a; // 8'b0 not necessary here
        else if (b <= a && b <= c && b <= d)
            min = b; // 8'b0 not necessary here
        else if (c <= a && c <= b && c <= d)
            min = c; // 8'b0 not necessary here
        else
            min = d; // 8'b0 not necessary here
    end

endmodule
[DONE]