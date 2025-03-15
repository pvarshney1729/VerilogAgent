module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min_out
);

    always @(*) begin
        min_out = a; // Start with the assumption that 'a' is the minimum
        if (b < min_out) min_out = b;
        if (c < min_out) min_out = c;
        if (d < min_out) min_out = d;
    end

endmodule