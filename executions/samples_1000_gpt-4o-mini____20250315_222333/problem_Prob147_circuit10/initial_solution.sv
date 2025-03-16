module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);
    logic ff;

    always @(posedge clk) begin
        if (a && !b) begin
            ff <= 1'b1;
        end else if (!a && b) begin
            ff <= 1'b0;
        end
    end

    assign state = ff;
    assign q = (ff && !b) ? 1'b0 : ff;

endmodule