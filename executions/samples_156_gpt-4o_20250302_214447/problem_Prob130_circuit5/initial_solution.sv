module TopModule (
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [3:0] c,
    input logic [3:0] d,
    input logic [3:0] e,
    output logic [3:0] q
);

always @(*) begin
    case (c)
        4'h0: q = b;
        4'h1: q = e;
        4'h2: q = a;
        4'h3: q = d;
        default: q = 4'hF; // Covers c = 4'h4 to 4'hF
    endcase
end

endmodule