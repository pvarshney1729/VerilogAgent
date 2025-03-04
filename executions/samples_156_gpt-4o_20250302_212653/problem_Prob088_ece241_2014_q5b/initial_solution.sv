module TopModule (
  input logic clk,       // Clock signal, positive edge-triggered
  input logic areset,    // Asynchronous active-high reset
  input logic x,         // Input signal for the FSM
  output logic z         // Output signal, determined by the FSM state transition
);

  typedef enum logic [1:0] {
    STATE_A = 2'b01,
    STATE_B = 2'b10
  } state_t;

  state_t current_state, next_state;

  // State transition and output logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= STATE_A;
      z <= 1'b0;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case (current_state)
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

endmodule