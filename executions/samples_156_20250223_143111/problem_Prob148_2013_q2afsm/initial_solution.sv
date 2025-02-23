module TopModule
(
  input  logic       clk,
  input  logic       resetn,
  input  logic [2:0] r,
  output logic [2:0] g
);

  // State encoding
  typedef enum logic [1:0] {A, B, C, D} state_t;

  // State variables
  state_t current_state, next_state;

  // State flip-flops
  always @( posedge clk ) begin
    if ( !resetn )
      current_state <= A;
    else
      current_state <= next_state;
  end

  // State table
  always @(*) begin
    case ( current_state )
      A: begin
        if      ( r[0] ) next_state = B;
        else if ( r[1] ) next_state = C;
        else             next_state = D;
      end
      B: next_state = r[0] ? B : A;
      C: next_state = r[1] ? C : A;
      default: next_state = A;
    endcase
  end

  // FSM outputs
  assign g[0] = (current_state == B);
  assign g[1] = (current_state == C);
  assign g[2] = (current_state == D);

endmodule