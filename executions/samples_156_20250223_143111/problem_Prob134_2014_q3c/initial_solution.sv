module TopModule
(
  input  logic clk,
  input  logic x,
  input  logic [2:0] y,
  output logic Y0,
  output logic z
);

  // Sequential logic

  logic [2:0] next_y;

  always @( posedge clk ) begin
    y <= next_y;
  end

  // Combinational logic

  always @(*) begin
    case (y)
      3'b000: next_y = x ? 3'b001 : 3'b000;
      3'b001: next_y = x ? 3'b100 : 3'b001;
      3'b010: next_y = x ? 3'b001 : 3'b010;
      3'b011: next_y = x ? 3'b010 : 3'b001;
      3'b100: next_y = x ? 3'b100 : 3'b011;
      default: next_y = 3'b000;
    endcase
  end

  // Output logic

  assign Y0 = next_y[0];

  assign z = (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0;

endmodule