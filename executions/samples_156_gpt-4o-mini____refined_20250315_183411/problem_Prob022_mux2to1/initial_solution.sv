module TopModule (
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);

    always @(*) begin
        if (sel == 1'b0) begin
            out = a;
        end else begin
            out = b;
        end
    end

endmodule