module TopModule
(
  input  logic clk,
  input  logic enable,
  input  logic S,
  input  logic [2:0] ABC,
  output logic Z
);

  // Sequential logic

  logic [7:0] Q;

  always @( posedge clk ) begin
    if ( enable )
      Q <= {S, Q[7:1]};
  end

  // Combinational logic

  assign Z = Q[ABC];

endmodule