module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic j,
  input  logic k,
  output logic out
);

  // State encoding

  typedef enum logic {OFF, ON} state_t;

  // State register

  state_t state_reg, state_next;

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      state_reg <= OFF;
    else
      state_reg <= state_next;
  end

  // State transition logic

  always @(*) begin
    state_next = state_reg;  // Default: stay in the current state
    case ( state_reg )
      OFF: if ( j ) state_next = ON;
      ON:  if ( k ) state_next = OFF;
    endcase
  end

  // Output logic

  assign out = ( state_reg == ON );

endmodule