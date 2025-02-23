module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic in,
  output logic out
);

  // State encoding

  typedef enum logic {A, B} state_t;

  // Sequential logic

  state_t current_state, next_state;

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      current_state <= B;
    else
      current_state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    case ( current_state )
      A: begin
        out = 0;
        if ( in )
          next_state = A;
        else
          next_state = B;
      end
      B: begin
        out = 1;
        if ( in )
          next_state = B;
        else
          next_state = A;
      end
    endcase
  end

endmodule