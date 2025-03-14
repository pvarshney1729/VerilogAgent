module TopModule (
  input  logic a,          // Most Significant Bit (MSB)
  input  logic b,          // Second Bit
  input  logic c,          // Third Bit
  input  logic d,          // Least Significant Bit (LSB)
  
  output logic out_sop,    // Output for minimum Sum-Of-Products
  output logic out_pos     // Output for minimum Product-Of-Sums
);

always @(*) begin
  // Default output states
  out_sop = 0;
  out_pos = 0;

  // Convert inputs to a single 4-bit value
  logic [3:0] input_value = {a, b, c, d}; // Concatenate a, b, c, d into a 4-bit value

  // Determine out_sop
  if (input_value == 4'b0010 || input_value == 4'b0111 || input_value == 4'b1111) begin
    out_sop = 1;
  end

  // Determine out_pos
  if (input_value == 4'b0000 || input_value == 4'b0001 || input_value == 4'b0100 || 
      input_value == 4'b0101 || input_value == 4'b0110 || input_value == 4'b1001 || 
      input_value == 4'b1010 || input_value == 4'b1101 || input_value == 4'b1110) begin
    out_pos = 1;
  end
end

endmodule