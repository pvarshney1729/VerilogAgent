module TopModule
(
  input  logic       clk,
  input  logic       load,
  input  logic [9:0] data,
  output logic       tc
);

  // Sequential logic

  logic [9:0] counter;

  always @( posedge clk ) begin
    if ( load )
      counter <= data;
    else if ( counter != 0 )
      counter <= counter - 1;
  end

  // Combinational logic

  assign tc = (counter == 0);

endmodule