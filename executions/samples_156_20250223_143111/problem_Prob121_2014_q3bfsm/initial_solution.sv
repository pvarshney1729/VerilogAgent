module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic x,
  output logic z
);

  // State encoding

  typedef enum logic [2:0] {
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100
  } state_t;

  // Sequential logic

  state_t y, y_next;

  always @( posedge clk ) begin
    if ( reset )
      y <= S0;
    else
      y <= y_next;
  end

  // Combinational logic

  always @(*) begin
    case ( y )
      S0: begin
        y_next = x ? S1 : S0;
        z = 0;
      end
      S1: begin
        y_next = x ? S4 : S1;
        z = 0;
      end
      S2: begin
        y_next = x ? S1 : S2;
        z = 0;
      end
      S3: begin
        y_next = x ? S2 : S1;
        z = 1;
      end
      S4: begin
        y_next = x ? S4 : S3;
        z = 1;
      end
      default: begin
        y_next = S0;
        z = 0;
      end
    endcase
  end

endmodule