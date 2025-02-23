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

  // State enumeration
  typedef enum logic [3:0] {WALK_LEFT, WALK_RIGHT, FALLING, DIGGING, SPLATTER} state_t;
  
  // State register
  state_t current_state, next_state;
  
  // Falling counter
  logic [4:0] fall_counter;

  // State transition and output logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
      fall_counter <= 0;
    end else begin
      current_state <= next_state;
      if (current_state == FALLING && ground == 0)
        fall_counter <= fall_counter + 1;
      else
        fall_counter <= 0;
    end
  end

  // Next state logic
  always @(*) begin
    // Default values
    next_state = current_state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
      WALK_LEFT: begin
        if (!ground)
          next_state = FALLING;
        else if (dig)
          next_state = DIGGING;
        else if (bump_left)
          next_state = WALK_RIGHT;
        else
          walk_left = 1;
      end
      WALK_RIGHT: begin
        if (!ground)
          next_state = FALLING;
        else if (dig)
          next_state = DIGGING;
        else if (bump_right)
          next_state = WALK_LEFT;
        else
          walk_right = 1;
      end
      FALLING: begin
        if (ground) begin
          if (fall_counter > 20)
            next_state = SPLATTER;
          else
            next_state = (current_state == WALK_LEFT) ? WALK_RIGHT : WALK_LEFT;
        end else
          aaah = 1;
      end
      DIGGING: begin
        if (!ground)
          next_state = FALLING;
        else
          digging = 1;
      end
      SPLATTER: begin
        // Do nothing
      end
    endcase
  end

endmodule