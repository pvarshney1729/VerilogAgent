module TopModule (
  input logic clk,
  input logic reset,
  input logic in,
  output logic out
);

  // State encoding
  typedef enum logic [1:0] {
    STATE_B = 2'b00,
    STATE_A = 2'b01
  } state_t;

  state_t current_state, next_state;

  // State transition logic
  always @(posedge clk) begin
    if (reset) begin
      current_state <= STATE_B;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic and output logic
  always @(*) begin
    case (current_state)
      STATE_B: begin
        out = 1;
        if (in == 0) begin
          next_state = STATE_A;
        end else begin
          next_state = STATE_B;
        end
      end
      STATE_A: begin
        out = 0;
        if (in == 0) begin
          next_state = STATE_B;
        end else begin
          next_state = STATE_A;
        end
      end
      default: begin
        next_state = STATE_B; // Default to a known state
        out = 1; // Default output
      end
    endcase
  end

endmodule