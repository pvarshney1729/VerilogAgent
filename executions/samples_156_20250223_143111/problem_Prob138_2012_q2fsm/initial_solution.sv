module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic w,
  output logic z
);

  // State encoding

  typedef enum logic [2:0] {A, B, C, D, E, F} state_t;

  // State flip-flops

  state_t current_state, next_state;

  always @( posedge clk ) begin
    if ( reset )
      current_state <= A;
    else
      current_state <= next_state;
  end

  // State table

  always @(*) begin
    case ( current_state )
      A: next_state = w ? B : A;
      B: next_state = w ? C : D;
      C: next_state = w ? E : D;
      D: next_state = w ? F : A;
      E: next_state = w ? E : D;
      F: next_state = w ? C : D;
      default: next_state = A;
    endcase
  end

  // FSM output

  assign z = (current_state == E || current_state == F) ? 1 : 0;

endmodule