module TopModule (
    input  logic [7:0] a,  // 8-bit unsigned input
    input  logic [7:0] b,  // 8-bit unsigned input
    input  logic [7:0] c,  // 8-bit unsigned input
    input  logic [7:0] d,  // 8-bit unsigned input
    output logic [7:0] min // 8-bit unsigned output representing the minimum value
);

    logic [7:0] min_temp1;
    logic [7:0] min_temp2;

    always_comb begin
        if (a < b)
            min_temp1 = a;
        else
            min_temp1 = b;

        if (c < d)
            min_temp2 = c;
        else
            min_temp2 = d;

        if (min_temp1 < min_temp2)
            min = min_temp1;
        else
            min = min_temp2;
    end

endmodule