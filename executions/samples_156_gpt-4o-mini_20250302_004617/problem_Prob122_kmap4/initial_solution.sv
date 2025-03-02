module TopModule (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    input logic c,
    output logic out
);

    always @(*) begin
        if (reset) begin
            out = 1'b0;
        end else begin
            out = (a & b) | (b & c) | (a & c); // Example logic from Karnaugh map
        end
    end

endmodule