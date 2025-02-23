module TopModule
(
  input  logic       clk,
  input  logic       load,
  input  logic       ena,
  input  logic [1:0] amount,
  input  logic [63:0] data,
  output logic [63:0] q
);

  // Sequential logic

  logic [63:0] reg_q;

  always @( posedge clk ) begin
    if ( load )
      reg_q <= data;
    else if ( ena ) begin
      case ( amount )
        2'b00: reg_q <= reg_q << 1;
        2'b01: reg_q <= reg_q << 8;
        2'b10: reg_q <= $signed(reg_q) >>> 1;
        2'b11: reg_q <= $signed(reg_q) >>> 8;
      endcase
    end
  end

  // Structural connections

  assign q = reg_q;

endmodule