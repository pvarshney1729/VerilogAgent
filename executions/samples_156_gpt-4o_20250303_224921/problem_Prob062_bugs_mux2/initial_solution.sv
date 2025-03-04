```verilog
module TopModule (
    // Signal Interface
    input        sel,        // Selection signal, 1-bit wide
    input  [7:0] a,          // 8-bit wide input 'a'
    input  [7:0] b,          // 8-bit wide input 'b'
    output logic [7:0] out   // 8-bit wide output 'out', matching input width
);

// Implementation
assign out = sel ? b : a;  // Use conditional operator for clear mux logic

endmodule
```