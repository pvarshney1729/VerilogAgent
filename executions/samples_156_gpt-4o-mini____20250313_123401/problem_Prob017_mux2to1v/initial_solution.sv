module TopModule (
    input  logic [99:0] a,
    input  logic [99:0] b,
    input  logic sel,
    output logic [99:0] out
);

    always @(*) begin
        out = (sel == 1'b0) ? a : b;
    end

endmodule