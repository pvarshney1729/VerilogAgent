module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic bump_left,
  input  logic bump_right,
  output logic walk_left,
  output logic walk_right
);

  // State encoding

  typedef enum logic {LEFT, RIGHT} state_t;

  // State register

  state_t current_state;

  // State transition and output logic

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      current_state <= LEFT;
    else begin
      case ( current_state )
        LEFT: begin
          if ( bump_left )
            current_state <= RIGHT;
        end
        RIGHT: begin
          if ( bump_right )
            current_state <= LEFT;
        end
      endcase
    end
  end

  // Output logic

  assign walk_left  = ( current_state == LEFT );
  assign walk_right = ( current_state == RIGHT );

endmodule