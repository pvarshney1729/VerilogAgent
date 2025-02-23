module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic bump_left,
  input  logic bump_right,
  input  logic ground,
  output logic walk_left,
  output logic walk_right,
  output logic aaah
);

  // State encoding
  typedef enum logic [1:0] {WALK_LEFT, WALK_RIGHT, FALLING} state_t;

  // State register
  state_t current_state, next_state;

  // State transition logic
  always @(posedge clk or posedge areset) begin
    if (areset)
      current_state <= WALK_LEFT;
    else
      current_state <= next_state;
  end

  // Next state logic
  always @(*) begin
    case (current_state)
      WALK_LEFT: begin
        if (!ground)
          next_state = FALLING;
        else if (bump_left)
          next_state = WALK_RIGHT;
        else
          next_state = WALK_LEFT;
      end
      WALK_RIGHT: begin
        if (!ground)
          next_state = FALLING;
        else if (bump_right)
          next_state = WALK_LEFT;
        else
          next_state = WALK_RIGHT;
      end
      FALLING: begin
        if (ground)
          next_state = current_state;
        else
          next_state = FALLING;
      end
    endcase
  end

  // Output logic
  assign walk_left  = (current_state == WALK_LEFT);
  assign walk_right = (current_state == WALK_RIGHT);
  assign aaah       = (current_state == FALLING);

endmodule