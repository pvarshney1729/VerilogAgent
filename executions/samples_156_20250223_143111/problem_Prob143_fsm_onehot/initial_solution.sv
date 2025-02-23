module TopModule
(
  input  logic       in,
  input  logic [9:0] state,
  output logic [9:0] next_state,
  output logic       out1,
  output logic       out2
);

  // Combinational logic

  always @(*) begin
    next_state = 10'b0000000001;  // Default to S0
    out1 = 0;
    out2 = 0;

    if (state[0] && in) next_state = 10'b0000000010;  // S0 --1--> S1
    if (state[1] && in) next_state = 10'b0000000100;  // S1 --1--> S2
    if (state[2] && in) next_state = 10'b0000001000;  // S2 --1--> S3
    if (state[3] && in) next_state = 10'b0000010000;  // S3 --1--> S4
    if (state[4] && in) next_state = 10'b0000100000;  // S4 --1--> S5
    if (state[5] && in) next_state = 10'b0001000000;  // S5 --1--> S6
    if (state[6] && in) next_state = 10'b0010000000;  // S6 --1--> S7
    if (state[7] && in) next_state = 10'b0010000000;  // S7 --1--> S7
    if (state[8] && in) next_state = 10'b0000000010;  // S8 --1--> S1
    if (state[9] && in) next_state = 10'b0000000010;  // S9 --1--> S1

    if (state[5] && !in) next_state = 10'b0100000000;  // S5 --0--> S8
    if (state[6] && !in) next_state = 10'b1000000000;  // S6 --0--> S9
    if (state[7] && !in) next_state = 10'b0000000001;  // S7 --0--> S0
    if (state[8] && !in) next_state = 10'b0000000001;  // S8 --0--> S0
    if (state[9] && !in) next_state = 10'b0000000001;  // S9 --0--> S0

    if (state[7]) begin  // S7 (0, 1)
      out2 = 1;
    end
    if (state[8]) begin  // S8 (1, 0)
      out1 = 1;
    end
    if (state[9]) begin  // S9 (1, 1)
      out1 = 1;
      out2 = 1;
    end
  end

endmodule