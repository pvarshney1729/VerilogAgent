module TopModule(
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] min
);

    always @(*) begin
        logic [7:0] min_ab;
        logic [7:0] min_cd;

        // Find minimum between a and b
        min_ab = (a < b) ? a : b;

        // Find minimum between c and d
        min_cd = (c < d) ? c : d;

        // Find minimum between min_ab and min_cd
        min = (min_ab < min_cd) ? min_ab : min_cd;
    end

endmodule