module TopModule
(
  input  logic       clk,
  input  logic       load,
  input  logic [1:0] ena,
  input  logic [99:0] data,
  output logic [99:0] q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( load )
      q <= data;
    else begin
      case ( ena )
        2'b01: q <= {q[0], q[99:1]}; // Rotate right
        2'b10: q <= {q[98:0], q[99]}; // Rotate left
        default: ; // Do not rotate
      endcase
    end
  end

endmodule