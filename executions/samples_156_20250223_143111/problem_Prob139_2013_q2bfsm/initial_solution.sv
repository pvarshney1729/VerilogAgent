module TopModule
(
  input  logic clk,
  input  logic resetn,
  input  logic x,
  input  logic y,
  output logic f,
  output logic g
);

  // State enumeration
  typedef enum logic [2:0] {A, B, C, D, E, F, G, H} state_t;
  
  // State register
  state_t current_state, next_state;

  // FSM logic
  always_ff @(posedge clk) begin
    if (!resetn)
      current_state <= A;
    else
      current_state <= next_state;
  end

  // Next state logic
  always_comb begin
    // Default values
    next_state = current_state;
    f = 0;
    g = 0;

    // State transitions
    case (current_state)
      A: begin
        f = 1;
        next_state = B;
      end
      B: begin
        if (x == 1) next_state = C;
      end
      C: begin
        if (x == 0) next_state = D;
      end
      D: begin
        if (x == 1) begin
          g = 1;
          next_state = E;
        end
      end
      E: begin
        if (y == 1) next_state = G;
        else next_state = F;
      end
      F: begin
        if (y == 1) next_state = G;
        else begin
          g = 0;
          next_state = H;
        end
      end
      G: begin
        g = 1;
      end
      H: begin
        g = 0;
      end
    endcase
  end

endmodule