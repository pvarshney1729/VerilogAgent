module TopModule
(
  input  logic clk,
  input  logic areset,
  input  logic in,
  output logic out
);

  // State encoding

  typedef enum logic [1:0] {A, B, C, D} state_t;

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
    case ( state )
      A: begin
        out = 0;
        next_state = in ? B : A;
      end
      B: begin
        out = 0;
        next_state = in ? B : C;
      end
      C: begin
        out = 0;
        next_state = in ? D : A;
      end
      D: begin
        out = 1;
        next_state = in ? B : C;
      end
    endcase
  end

endmodule