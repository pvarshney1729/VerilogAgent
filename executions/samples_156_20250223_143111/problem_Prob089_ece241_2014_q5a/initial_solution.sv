module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic x,
  output logic z
);

  // State definitions
  typedef enum logic {ZERO, ONE, FLIP} state_t;
  state_t current_state, next_state;

  // Sequential logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset)
      current_state <= ZERO;
    else
      current_state <= next_state;
  end

  // Next state logic
  always_comb begin
    case (current_state)
      ZERO: begin
        if (x)
          next_state = FLIP;
        else
          next_state = ZERO;
      end
      ONE: begin
        if (x)
          next_state = ONE;
        else
          next_state = FLIP;
      end
      FLIP: begin
        if (x)
          next_state = FLIP;
        else
          next_state = ONE;
      end
    endcase
  end

  // Output logic
  always_comb begin
    case (current_state)
      ZERO: z = x;
      ONE:  z = x;
      FLIP: z = ~x;
    endcase
  end

endmodule