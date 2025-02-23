module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic in_,
  output logic disc,
  output logic flag,
  output logic err
);

  // State enumeration
  typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8} state_t;

  // State variables
  state_t current_state, next_state;

  // FSM logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= S0;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    disc = 0;
    flag = 0;
    err = 0;
    case (current_state)
      S0: next_state = in_ ? S1 : S0;
      S1: next_state = in_ ? S2 : S0;
      S2: next_state = in_ ? S3 : S0;
      S3: next_state = in_ ? S4 : S0;
      S4: next_state = in_ ? S5 : S0;
      S5: next_state = in_ ? S6 : S0;
      S6: next_state = in_ ? S7 : S0;
      S7: next_state = in_ ? S8 : S0;
      S8: next_state = in_ ? S8 : S0;
      default: next_state = S0;
    endcase

    // Output logic
    case (current_state)
      S5: disc = in_;
      S6: flag = !in_;
      S7, S8: err = 1;
      default: ;
    endcase
  end

endmodule