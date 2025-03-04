module TopModule (
    logic clk,
    logic [7:0] d,
    logic [7:0] q
);

always @(posedge clk) begin
    q <= d;
end

endmodule