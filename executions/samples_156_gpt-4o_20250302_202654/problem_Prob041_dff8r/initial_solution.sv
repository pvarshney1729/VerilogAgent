module TopModule(
    input wire clk,
    input wire reset,
    input wire [7:0] d,
    output reg [7:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000;
    end else begin
        q <= d;
    end
end

endmodule