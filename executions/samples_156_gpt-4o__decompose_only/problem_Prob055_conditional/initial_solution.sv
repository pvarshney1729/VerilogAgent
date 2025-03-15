module TopModule(
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] min
);

    logic [7:0] min_ab;
    logic [7:0] min_cd;

    // Determine the minimum of a and b
    always @(*) begin
        if (a < b) begin
            min_ab = a;
        end else begin
            min_ab = b;
        end
    end

    // Determine the minimum of c and d
    always @(*) begin
        if (c < d) begin
            min_cd = c;
        end else begin
            min_cd = d;
        end
    end

    // Determine the minimum of min_ab and min_cd
    always @(*) begin
        if (min_ab < min_cd) begin
            min = min_ab;
        end else begin
            min = min_cd;
        end
    end

endmodule