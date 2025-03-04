module TopModule (
  input logic clk,
  input logic areset,
  input logic x,
  output logic z
);

  logic [1:0] state; // One-hot encoded state

  // State Definitions
  localparam STATE_A = 2'b01;
  localparam STATE_B = 2'b10;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= STATE_A;
      z <= 1'b0;
    end else begin
      case (state)
        STATE_A: begin
          if (x == 1'b1) begin
            state <= STATE_B;
            z <= 1'b1;
          end else begin
            z <= 1'b0;
          end
        end
        STATE_B: begin
          if (x == 1'b0) begin
            z <= 1'b1;
          end else begin
            z <= 1'b0;
          end
        end
        default: begin
          state <= STATE_A;
          z <= 1'b0;
        end
      endcase
    end
  end
endmodule