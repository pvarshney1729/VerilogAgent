module TopModule (
    input  logic [1023:0] in,
    input  logic [7:0]    sel,
    output logic [3:0]    out
);

    always @(*) begin
        out = in[(sel * 4) +: 4];
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly