module TopModule
(
  input  logic mode,
  input  logic too_cold,
  input  logic too_hot,
  input  logic fan_on,
  output logic heater,
  output logic aircon,
  output logic fan
);

  // Combinational logic

  assign heater = mode & too_cold;
  assign aircon = ~mode & too_hot;
  assign fan = heater | aircon | fan_on;

endmodule