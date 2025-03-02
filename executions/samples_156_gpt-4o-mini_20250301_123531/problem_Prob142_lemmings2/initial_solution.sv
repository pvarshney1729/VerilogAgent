module TopModule (
  input logic clk,
  input logic areset,
  input logic bump_left,
  input logic bump_right,
  input logic ground,
  output logic walk_left,
  output logic walk_right,
  output logic aaah
);

  typedef enum logic [1:0] {
    Walk_Left = 2'b00,
    Walk_Right = 2'b01,
    Falling = 2'b10
  } state_t;

  state_t current_state, next_state;

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= Walk_Left;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    next_state = current_state; // Default to hold state
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    case (current_state)
      Walk_Left: begin
        walk_left = 1;
        if (!ground) begin
          next_state = Falling;
        end else if (bump_left || (bump_left && bump_right)) begin
          next_state = Walk_Right;
        end
      end

      Walk_Right: begin
        walk_right = 1;
        if (!ground) begin
          next_state = Falling;
        end else if (bump_right || (bump_left && bump_right)) begin
          next_state = Walk_Left;
        end
      end

      Falling: begin
        aaah = 1;
        if (ground) begin
          if (current_state == Walk_Left) begin
            next_state = Walk_Left;
          end else if (current_state == Walk_Right) begin
            next_state = Walk_Right;
          end
        end
      end
    endcase
  end

endmodule