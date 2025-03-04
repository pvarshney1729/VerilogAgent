module TopModule (
  input logic clk,                // Clock input
  input logic reset,              // Active-high synchronous reset
  input logic [2:0] s,            // 3-bit input representing sensor states, where s[2] is MSB
  output logic fr2,               // Flow rate control output
  output logic fr1,               // Flow rate control output
  output logic fr0,               // Flow rate control output
  output logic dfr                // Supplemental flow valve control output
);

  logic [2:0] prev_s;             // Register to store previous state of s

  always_ff @(posedge clk) begin
    if (reset) begin
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      fr0 <= 1'b1;
      dfr <= 1'b1;
      prev_s <= 3'b000;
    end else begin
      case (s)
        3'b111: begin
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          fr0 <= 1'b0;
          dfr <= 1'b0;
        end
        3'b110: begin
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          fr0 <= 1'b1;
          dfr <= 1'b0;
        end
        3'b100: begin
          fr2 <= 1'b0;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b0;
        end
        3'b000: begin
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b1;
        end
        default: begin
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          fr0 <= 1'b1;
          dfr <= 1'b1;
        end
      endcase

      // Detect transition from a lower to a higher water level
      if (s > prev_s) begin
        dfr <= 1'b1;
      end

      // Update previous state
      prev_s <= s;
    end
  end

endmodule