module TopModule (
  input wire clk,
  input wire reset,
  input wire shift_ena,
  input wire count_ena,
  input wire data,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0000;
  end else if (shift_ena && !count_ena) begin
    q <= {q[2:0], data};
  end else if (count_ena && !shift_ena) begin
    q <= q - 1;
  end
end

endmodule