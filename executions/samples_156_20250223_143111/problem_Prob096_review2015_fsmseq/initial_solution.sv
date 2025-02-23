module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic data,
  output logic start_shifting
);

  // State encoding

  typedef enum logic [1:0] {S0, S1, S2, S3} state_t;

  // Sequential logic

  state_t current_state, next_state;

  always @( posedge clk ) begin
    if ( reset )
      current_state <= S0;
    else
      current_state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    // Default values
    next_state = current_state;
    start_shifting = 0;

    case ( current_state )
      S0: if ( data ) next_state = S1;
      S1: if ( data ) next_state = S2; else next_state = S0;
      S2: if ( data ) next_state = S2; else next_state = S3;
      S3: begin
            if ( data ) next_state = S1;
            start_shifting = 1;
          end
    endcase
  end

endmodule