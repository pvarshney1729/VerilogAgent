module TopModule
(
  input  logic clk,
  input  logic w,
  input  logic R,
  input  logic E,
  input  logic L,
  output logic Q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( E ) begin
      if ( L )
        Q <= R;
      else
        Q <= w;
    end
  end

endmodule