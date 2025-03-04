module TopModule (
  input logic [2:0] y,
  input logic w,
  input logic clk,
  input logic rst,
  output logic Y1
);
  always @(posedge clk) begin
    if (rst) begin
      y <= 3'b000; // Reset to State A
    end else begin
      case (y)
        3'b000: y <= (w) ? 3'b000 : 3'b001; // State A
        3'b001: y <= (w) ? 3'b011 : 3'b010; // State B
        3'b010: y <= (w) ? 3'b011 : 3'b100; // State C
        3'b011: y <= (w) ? 3'b000 : 3'b101; // State D
        3'b100: y <= (w) ? 3'b011 : 3'b100; // State E
        3'b101: y <= (w) ? 3'b011 : 3'b010; // State F
        default: y <= 3'b000; // Default to State A
      endcase
    end
  end

  assign Y1 = y[1]; // Output logic

endmodule