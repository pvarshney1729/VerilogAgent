module TopModule (
    input logic clock,
    input logic a,
    output logic p = 0,
    output logic q = 0
);

always @(posedge clock) begin
    if (a) begin
        p <= 1;
        if (p == 0) begin
            q <= ~q;
        end
    end
end

endmodule