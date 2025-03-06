module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    always @(posedge clock) begin
        if (a)
            p <= 1'b1;
        else
            p <= 1'b0;
        q <= p;
    end
endmodule