module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min
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