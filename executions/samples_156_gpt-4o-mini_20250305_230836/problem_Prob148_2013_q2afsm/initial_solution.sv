```verilog
[BEGIN]
module TopModule (
  input logic clk,
  input logic resetn,
  input logic [2:0] r, // r[0] is the highest priority, and r[2] is the lowest
  output logic [2:0] g  // g[0] is the grant for r[0], etc.
);

  typedef enum logic [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11
  } state_t;

  state_t current_state, next_state;

  // State transition logic
  always @(*) begin
    case (current_state)
      STATE_A: begin
        if (r[0]) next_state = STATE_B;
        else if (r[1]) next_state = STATE_C;
        else if (r[2]) next_state = STATE_D;
        else next_state = STATE_A;
      end
      STATE_B: begin
        if (r[0]) next_state = STATE_B;
        else next_state = STATE_A;
      end
      STATE_C: begin
        if (r[1]) next_state = STATE_C;
        else next_state = STATE_A;
      end
      STATE_D: begin
        if (r[2]) next_state = STATE_D;
        else next_state = STATE_A;
      end
      default: next_state = STATE_A;
    endcase
  end

  // State flip-flops with synchronous reset
  always @(posedge clk) begin
    if (!resetn) begin
      current_state <= STATE_A;
    end else begin
      current_state <= next_state;
    end
  end

  // Output logic based on current state
  always @(*) begin
    case (current_state)
      STATE_A: g = 3'b000;
      STATE_B: g = 3'b001;
      STATE_C: g = 3'b010;
      STATE_D: g = 3'b100;
      default: g = 3'b000;
    endcase
  end

endmodule
[DONE]
```