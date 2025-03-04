module TopModule(
  input [3:0] in_vec,
  output reg [1:0] pos
);
  always @(*) begin
    casex (in_vec)
      4'b1xxx: pos = 2'b11; // Highest priority to MSB
      4'b01xx: pos = 2'b10;
      4'b001x: pos = 2'b01;
      4'b0001: pos = 2'b00;
      default: pos = 2'b00; // If all zeros
    endcase
  end
endmodule