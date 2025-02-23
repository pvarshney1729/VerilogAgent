module TopModule
(
  input  logic       d,
  input  logic       done_counting,
  input  logic       ack,
  input  logic [9:0] state,
  output logic       B3_next,
  output logic       S_next,
  output logic       S1_next,
  output logic       Count_next,
  output logic       Wait_next,
  output logic       done,
  output logic       counting,
  output logic       shift_ena
);

  // State transition logic

  assign S_next     = (state == 10'b0000000001 && d == 0) || (state == 10'b0000000100 && d == 0) || (state == 10'b0000001000 && d == 0) || (state == 10'b1000000000 && ack == 1);
  assign S1_next    = (state == 10'b0000000001 && d == 1);
  assign B3_next    = (state == 10'b0000010000);
  assign Count_next = (state == 10'b0000100000 && done_counting == 0) || (state == 10'b0001000000 && ack == 0);
  assign Wait_next  = (state == 10'b0000100000 && done_counting == 1);

  // Output logic

  assign done       = (state == 10'b1000000000);
  assign counting   = (state == 10'b0000100000);
  assign shift_ena  = (state >= 10'b0000001000 && state <= 10'b0000100000);

endmodule