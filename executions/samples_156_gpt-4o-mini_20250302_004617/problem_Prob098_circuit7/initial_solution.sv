module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    always @(posedge clk) begin
        if (a) begin
            q <= ~q; // Toggle q when a is high
        end
    end

endmodule