module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    initial begin
        q = 1'b0; // Initialize q to 0
    end

    always @(posedge clk) begin
        q <= d; // Capture d on the rising edge of clk
    end

endmodule