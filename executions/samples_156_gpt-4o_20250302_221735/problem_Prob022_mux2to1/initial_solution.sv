module TopModule (
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);

    // Combinational logic for 2-to-1 multiplexer
    always @(*) begin
        out = (sel == 1'b0) ? a : b;
    end

endmodule