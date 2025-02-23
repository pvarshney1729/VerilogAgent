module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic in,
  output logic out
);

  // State encoding

  typedef enum logic [1:0] {A, B, C, D} state_t;

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
    // Default values
    next_state = current_state;
    out = 0;

    // State transitions and output logic
    case ( current_state )
      A: begin
        if ( in )
          next_state = B;
        out = 0;
      end
      B: begin
        if ( !in )
          next_state = C;
        out = 0;
      end
      C: begin
        if ( in )
          next_state = D;
        else
          next_state = A;
        out = 0;
      end
      D: begin
        if ( !in )
          next_state = C;
        else
          next_state = B;
        out = 1;
      end
    endcase
  end

endmodule