module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

always @(posedge clk) begin
    if (a) begin
        q <= 1'b1; // Set q to 1 if a is 1
    end else begin
        if (q == 1'b1) begin
            q <= 1'b0; // Reset q to 0 if it was previously 1 and a is now 0
        end
    end
end

endmodule