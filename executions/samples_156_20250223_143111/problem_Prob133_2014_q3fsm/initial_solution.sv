module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic s,
  input  logic w,
  output logic z
);

  // State encoding

  typedef enum logic [2:0] {A, B, C, D, E, F, G} state_t;

  // Sequential logic

  state_t current_state, next_state;
  logic   count;

  always @( posedge clk or posedge reset ) begin
    if ( reset ) begin
      current_state <= A;
      count <= 0;
    end else begin
      current_state <= next_state;
      if ( current_state >= B && current_state <= D && w )
        count <= count + 1;
      else if ( current_state == E )
        count <= 0;
    end
  end

  // Combinational logic

  always @(*) begin
    case ( current_state )
      A: if ( s ) next_state = B;
         else     next_state = A;
      B: next_state = C;
      C: next_state = D;
      D: next_state = E;
      E: next_state = F;
      F: next_state = G;
      G: next_state = B;
      default: next_state = A;
    endcase
  end

  // Structural connections

  assign z = ( current_state == F && count == 2 ) ? 1 : 0;

endmodule