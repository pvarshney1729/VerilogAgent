module TopModule (
  input wire clk,
  input wire areset,
  input wire x,
  output reg z
);

  typedef enum reg [1:0] {
    STATE_A = 2'b01,
    STATE_B = 2'b10
  } state_t;

  state_t state, next_state;

  // State transition logic
  always @(*) begin
    case (state)
      STATE_A: begin
        if (x) begin
          next_state = STATE_B;
          z = 1'b1;
        end else begin
          next_state = STATE_A;
          z = 1'b0;
        end
      end
      STATE_B: begin
        if (x) begin
          next_state = STATE_B;
          z = 1'b0;
        end else begin
          next_state = STATE_B;
          z = 1'b1;
        end
      end
      default: begin
        next_state = STATE_A;
        z = 1'b0;
      end
    endcase
  end

  // State register update
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= STATE_A;
      z <= 1'b0;
    end else begin
      state <= next_state;
    end
  end
endmodule