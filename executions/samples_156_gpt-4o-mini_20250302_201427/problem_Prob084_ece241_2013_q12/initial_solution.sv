module TopModule(
    input logic clk,
    input logic rst_n,
    input logic enable,
    input logic S,
    input logic A, B, C,
    output logic Z
);

  logic [7:0] Q; // 8-bit shift register

  // Shift Register Logic
  always @(posedge clk) begin
    if (!rst_n)
      Q <= 8'b00000000; // Reset all flip-flops to 0
    else if (enable)
      Q <= {S, Q[7:1]}; // Shift right, MSB in first
  end

  // Multiplexer Logic
  always @(*) begin
    case ({A, B, C})
      3'b000: Z = Q[0];
      3'b001: Z = Q[1];
      3'b010: Z = Q[2];
      3'b011: Z = Q[3];
      3'b100: Z = Q[4];
      3'b101: Z = Q[5];
      3'b110: Z = Q[6];
      3'b111: Z = Q[7];
      default: Z = 1'bx; // Undefined state
    endcase
  end

endmodule