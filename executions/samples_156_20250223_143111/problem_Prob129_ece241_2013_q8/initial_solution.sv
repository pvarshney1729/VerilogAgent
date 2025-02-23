module TopModule
(
  input  logic clk,
  input  logic aresetn,
  input  logic x,
  output logic z
);

  // State encoding

  typedef enum logic [1:0] {S0, S1, S2} state_t;

  // Sequential logic

  state_t current_state, next_state;

  always @( posedge clk or negedge aresetn ) begin
    if ( ~aresetn )
      current_state <= S0;
    else
      current_state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    next_state = current_state;
    z = 0;
    case ( current_state )
      S0: begin
        if ( x )
          next_state = S1;
      end
      S1: begin
        if ( ~x )
          next_state = S2;
        else
          next_state = S1;
      end
      S2: begin
        if ( x ) begin
          next_state = S1;
          z = 1;
        end
        else
          next_state = S0;
      end
    endcase
  end

endmodule