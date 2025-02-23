module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic x,
  output logic z
);

  // State encoding

  typedef enum logic {A=1'b0, B=1'b1} state_t;

  // Sequential logic

  state_t state, next_state;

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      state <= A;
    else
      state <= next_state;
  end

  // Combinational logic

  always @(*) begin
    // Default values
    next_state = state;
    z = 0;

    // State transitions and outputs
    case ( state )
      A: begin
        if ( x == 0 ) begin
          next_state = A;
          z = 0;
        end
        else begin
          next_state = B;
          z = 1;
        end
      end
      B: begin
        if ( x == 0 ) begin
          next_state = B;
          z = 1;
        end
        else begin
          next_state = B;
          z = 0;
        end
      end
    endcase
  end

endmodule