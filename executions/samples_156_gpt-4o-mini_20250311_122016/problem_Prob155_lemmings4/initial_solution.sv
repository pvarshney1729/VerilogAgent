[BEGIN]
module TopModule (
  input logic clk,            // Clock signal, positive edge-triggered
  input logic areset,         // Asynchronous reset, active high
  input logic bump_left,      // Lemming hits an obstacle on the left
  input logic bump_right,     // Lemming hits an obstacle on the right
  input logic ground,         // Indicates if the ground is present (1 = ground present)
  input logic dig,            // Command to start digging
  output logic walk_left,      // Lemming walking left
  output logic walk_right,     // Lemming walking right
  output logic aaah,           // Lemming is falling
  output logic digging         // Lemming is digging
);

  // State encoding
  typedef enum logic [2:0] {
    WALK_LEFT = 3'b000,
    WALK_RIGHT = 3'b001,
    FALLING = 3'b010,
    DIGGING = 3'b011,
    SPLATTERED = 3'b100
  } state_t;

  state_t current_state, next_state;
  logic [4:0] fall_counter; // Counter for falling cycles

  // Asynchronous reset logic
  always_ff @(posedge clk) begin
    if (areset) begin
      current_state <= WALK_LEFT;
      fall_counter <= 0;
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      current_state <= next_state;
      if (current_state == FALLING) begin
        fall_counter <= fall_counter + 1;
      end else begin
        fall_counter <= 0;
      end
    end
  end

  // Next state logic
  always_ff @(*) begin
    // Default assignments
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    next_state = current_state; // Default next state

    case (current_state)
      WALK_LEFT: begin
        walk_left = 1;
        if (!ground) begin
          next_state = FALLING;
        end else if (dig) begin
          next_state = DIGGING;
        end else if (bump_right) begin
          next_state = WALK_RIGHT;
        end
      end

      WALK_RIGHT: begin
        walk_right = 1;
        if (!ground) begin
          next_state = FALLING;
        end else if (dig) begin
          next_state = DIGGING;
        end else if (bump_left) begin
          next_state = WALK_LEFT;
        end
      end

      FALLING: begin
        aaah = 1;
        if (ground) begin
          if (fall_counter > 20) begin
            next_state = SPLATTERED;
          end else begin
            next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
          end
        end
      end

      DIGGING: begin
        digging = 1;
        if (!ground) begin
          next_state = FALLING;
        end
      end

      SPLATTERED: begin
        // Remain in splattered state
      end

      default: begin
        next_state = WALK_LEFT; // Default to walking left
      end
    endcase
  end

endmodule
[DONE]