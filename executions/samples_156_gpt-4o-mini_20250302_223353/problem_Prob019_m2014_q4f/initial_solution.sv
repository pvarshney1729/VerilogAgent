module TopModule (
  logic in1,  // First input 
  logic in2,  // Second input
  logic out   // Output
);
  assign out = in1 & ~in2; // Perform AND operation with 'in2' inverted
endmodule