module TopModule
(
  input  logic [15:0] scancode,
  output logic        left,
  output logic        down,
  output logic        right,
  output logic        up
);

  // Combinational logic

  always @(*) begin
    // Default values
    left = 0;
    down = 0;
    right = 0;
    up = 0;

    // Scancode mapping
    case (scancode)
      16'he06b: left = 1;
      16'he072: down = 1;
      16'he074: right = 1;
      16'he075: up = 1;
      default: ; // Do nothing
    endcase
  end

endmodule