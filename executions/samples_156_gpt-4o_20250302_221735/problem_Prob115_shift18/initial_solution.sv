module TopModule (
  input logic clk,
  input logic load,
  input logic ena,
  input logic [1:0] amount,
  input logic signed [63:0] data,
  output logic signed [63:0] q
);
  always_ff @(posedge clk) begin
    if (load) begin
      q <= data;
    end else if (ena) begin
      case (amount)
        2'b00: q <= q <<< 1;
        2'b01: q <= q <<< 8;
        2'b10: q <= q >>> 1;
        2'b11: q <= q >>> 8;
        default: q <= q; // Default case to handle unexpected values
      endcase
    end
  end
endmodule