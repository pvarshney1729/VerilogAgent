module TopModule (
    input logic a,
    input logic b,
    input logic clk,
    input logic reset,
    output logic y_assign,
    output logic y_always
);

assign y_assign = a & b;

always @(*) begin
    if (reset) begin
        y_always = 1'b0;
    end else begin
        y_always = a & b;
    end
end

endmodule