module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic in,
  output logic out
);

  // State encoding

  typedef enum logic {A, B} state_t;

  // Sequential logic

  state_t current_state, next_state;

  always @( posedge clk or posedge reset ) begin
    if ( reset )
      current_state <= B;
    else
      current_state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    case ( current_state )
      A: begin
        if ( in )
          next_state = A;
        else
          next_state = B;
      end
      B: begin
        if ( in )
          next_state = B;
        else
          next_state = A;
      end
    endcase
  end

  // Output logic

  assign out = ( current_state == B ) ? 1 : 0;

endmodule