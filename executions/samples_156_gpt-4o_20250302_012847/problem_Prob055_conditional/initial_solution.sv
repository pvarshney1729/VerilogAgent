module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min_value
);

    always @(*) begin
        logic [7:0] min_ab;
        logic [7:0] min_cd;

        // Find minimum between a and b
        if (a < b) 
            min_ab = a;
        else 
            min_ab = b;

        // Find minimum between c and d
        if (c < d) 
            min_cd = c;
        else 
            min_cd = d;

        // Find minimum between min_ab and min_cd
        if (min_ab < min_cd) 
            min_value = min_ab;
        else 
            min_value = min_cd;
    end

endmodule