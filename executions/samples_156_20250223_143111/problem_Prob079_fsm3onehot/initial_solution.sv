module TopModule
(
  input  logic       in,
  input  logic [3:0] state,
  output logic [3:0] next_state,
  output logic       out
);

  // State transition logic

  assign next_state = (state == 4'b0001) ? (in ? 4'b0010 : 4'b0001) :
                      (state == 4'b0010) ? (in ? 4'b0010 : 4'b0100) :
                      (state == 4'b0100) ? (in ? 4'b1000 : 4'b0001) :
                      (state == 4'b1000) ? (in ? 4'b0010 : 4'b0100) : 4'b0000;

  // Output logic

  assign out = (state == 4'b1000);

endmodule