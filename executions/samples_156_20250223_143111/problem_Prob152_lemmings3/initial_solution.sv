module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic bump_left,
  input  logic bump_right,
  input  logic ground,
  input  logic dig,
  output logic walk_left,
  output logic walk_right,
  output logic aaah,
  output logic digging
);

  // State encoding

  typedef enum logic [2:0] {
    WALK_LEFT  = 3'b001,
    WALK_RIGHT = 3'b010,
    FALL       = 3'b100,
    DIG        = 3'b011
  } state_t;

  // State register

  state_t current_state, next_state;

  // State transition logic

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      current_state <= WALK_LEFT;
    else
      current_state <= next_state;
  end

  // Next state logic

  always @(*) begin
    case ( current_state )
      WALK_LEFT: begin
        if ( !ground )
          next_state = FALL;
        else if ( dig )
          next_state = DIG;
        else if ( bump_left || bump_right )
          next_state = WALK_RIGHT;
        else
          next_state = WALK_LEFT;
      end
      WALK_RIGHT: begin
        if ( !ground )
          next_state = FALL;
        else if ( dig )
          next_state = DIG;
        else if ( bump_left || bump_right )
          next_state = WALK_LEFT;
        else
          next_state = WALK_RIGHT;
      end
      FALL: begin
        if ( ground )
          next_state = current_state[1] ? WALK_RIGHT : WALK_LEFT;
        else
          next_state = FALL;
      end
      DIG: begin
        if ( !ground )
          next_state = FALL;
        else if ( dig )
          next_state = DIG;
        else
          next_state = current_state[1] ? WALK_RIGHT : WALK_LEFT;
      end
    endcase
  end

  // Output logic

  assign walk_left  = ( current_state == WALK_LEFT );
  assign walk_right = ( current_state == WALK_RIGHT );
  assign aaah       = ( current_state == FALL );
  assign digging    = ( current_state == DIG );

endmodule