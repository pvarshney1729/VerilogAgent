module TopModule (
  input logic in,                   // 1-bit input, unsigned
  input logic [9:0] state,          // 10-bit input vector representing current state using one-hot encoding
  output logic [9:0] next_state,    // 10-bit output vector for next state using one-hot encoding
  output logic out1,                // 1-bit output, unsigned
  output logic out2                 // 1-bit output, unsigned
);

  always @(*) begin
    // Default outputs
    next_state = 10'b0000000001; // Default to S0
    out1 = 1'b0;
    out2 = 1'b0;

    // State transition logic
    case (1'b1) // One-hot encoding, only one bit should be high
      state[0]: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
      state[1]: next_state = in ? 10'b0000000100 : 10'b0000000010; // S1
      state[2]: next_state = in ? 10'b0000001000 : 10'b0000000100; // S2
      state[3]: next_state = in ? 10'b0000010000 : 10'b0000001000; // S3
      state[4]: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
      state[5]: next_state = in ? 10'b0001000000 : 10'b0000100000; // S5
      state[6]: next_state = in ? 10'b0010000000 : 10'b0001000000; // S6
      state[7]: begin
        next_state = in ? 10'b0100000000 : 10'b0010000000; // S7
        out2 = 1'b1;
      end
      state[8]: begin
        next_state = in ? 10'b1000000000 : 10'b0100000000; // S8
        out1 = 1'b1;
      end
      state[9]: begin
        next_state = in ? 10'b0000000001 : 10'b1000000000; // S9
        out1 = 1'b1;
        out2 = 1'b1;
      end
      default: next_state = 10'b0000000001; // Default to S0 if no valid state
    endcase
  end

endmodule