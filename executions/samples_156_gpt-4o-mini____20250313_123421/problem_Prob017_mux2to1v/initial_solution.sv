module TopModule (
    input logic [99:0] a,
    input logic [99:0] b,
    input logic sel,
    output logic [99:0] out
);

    always @(*) begin
        if (sel == 1'b0) begin
            out = a;
        end else begin
            out = b;
        end
    end

endmodule