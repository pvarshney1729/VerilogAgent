module TopModule(
    input  [7:0] a,
    input  [7:0] b,
    input  [7:0] c,
    input  [7:0] d,
    output [7:0] min
);

    // Declare internal signals to hold intermediate minimum values
    logic [7:0] min_ab;
    logic [7:0] min_cd;

    // Combinational logic to determine the minimum of a and b
    always @(*) begin
        if (a < b) 
            min_ab = a;
        else 
            min_ab = b;
    end

    // Combinational logic to determine the minimum of c and d
    always @(*) begin
        if (c < d) 
            min_cd = c;
        else 
            min_cd = d;
    end

    // Combinational logic to find the overall minimum of min_ab and min_cd
    always @(*) begin
        if (min_ab < min_cd) 
            min = min_ab;
        else 
            min = min_cd;
    end

endmodule