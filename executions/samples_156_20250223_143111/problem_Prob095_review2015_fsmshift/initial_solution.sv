module TopModule
(
  input  logic clk,
  input  logic reset,
  output logic shift_ena
);

  // Sequential logic

  logic [2:0] counter;

  always @( posedge clk ) begin
    if ( reset )
      counter <= 3'b100;
    else if ( counter != 3'b000 )
      counter <= counter - 1;
  end

  // Combinational logic

  assign shift_ena = (counter != 3'b000) ? 1'b1 : 1'b0;

endmodule