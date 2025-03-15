module TopModule (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [7:0] c,
    input  logic [7:0] d,
    output logic [7:0] min
);
    always @(*) begin
        min = (a < b) ? (a < c ? (a < d ? a : d) : (c < d ? c : d)) :
                        (b < c ? (b < d ? b : d) : (c < d ? c : d));
    end
endmodule