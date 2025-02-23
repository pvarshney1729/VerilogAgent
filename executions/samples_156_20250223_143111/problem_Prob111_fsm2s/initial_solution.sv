module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic j,
  input  logic k,
  output logic out
);

  // State encoding

  typedef enum logic {OFF, ON} state_t;

  // Sequential logic

  state_t current_state, next_state;

  always @( posedge clk or posedge reset ) begin
    if ( reset )
      current_state <= OFF;
    else
      current_state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    case ( current_state )
      OFF: begin
        if ( j )
          next_state = ON;
        else
          next_state = OFF;
      end
      ON: begin
        if ( k )
          next_state = OFF;
        else
          next_state = ON;
      end
    endcase
  end

  // Output logic

  assign out = ( current_state == ON ) ? 1 : 0;

endmodule