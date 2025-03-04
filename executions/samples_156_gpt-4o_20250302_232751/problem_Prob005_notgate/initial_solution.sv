module TopModule (
  input wire in_signal,
  output wire out_signal
);

  // NOT gate logic
  assign out_signal = ~in_signal;

endmodule