module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] c,
    input logic [7:0] d,
    output logic [7:0] min
);

always @(*) begin
    logic [7:0] temp_min_ab;
    logic [7:0] temp_min_cd;

    temp_min_ab = (a < b) ? a : b;
    temp_min_cd = (c < d) ? c : d;
    min = (temp_min_ab < temp_min_cd) ? temp_min_ab : temp_min_cd;
end

endmodule