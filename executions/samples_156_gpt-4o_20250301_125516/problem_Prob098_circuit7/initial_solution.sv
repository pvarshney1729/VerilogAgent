module TopModule (
  input wire clk,
  input wire reset,
  input wire a,
  output reg q
);

  always @(posedge clk) begin
    if (reset) begin
      q <= 1'b0;
    end else if (a == 1'b1) begin
      q <= ~q;
    end
  end

endmodule