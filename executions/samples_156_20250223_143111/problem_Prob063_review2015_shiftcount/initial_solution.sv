module TopModule
(
  input  logic clk,
  input  logic shift_ena,
  input  logic count_ena,
  input  logic data,
  output logic [3:0] q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( shift_ena )
      q <= {data, q[3:1]};
    else if ( count_ena )
      q <= q - 1;
  end

endmodule