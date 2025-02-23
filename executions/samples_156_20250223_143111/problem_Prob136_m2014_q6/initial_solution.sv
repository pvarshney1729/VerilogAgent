module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic w,
  output logic z
);

  // State encoding

  typedef enum logic [2:0] {A, B, C, D, E, F} state_t;

  // Sequential logic

  state_t current_state, next_state;

  always @( posedge clk or posedge reset ) begin
    if ( reset )
      current_state <= A;
    else
      current_state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    case ( current_state )
      A: begin
        z = 0;
        next_state = w ? A : B;
      end
      B: begin
        z = 0;
        next_state = w ? D : C;
      end
      C: begin
        z = 0;
        next_state = w ? D : E;
      end
      D: begin
        z = 0;
        next_state = w ? A : F;
      end
      E: begin
        z = 1;
        next_state = w ? D : E;
      end
      F: begin
        z = 1;
        next_state = w ? D : C;
      end
    endcase
  end

endmodule