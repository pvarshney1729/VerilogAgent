```verilog
[BEGIN]
module TopModule (
    input        sel,      // Selection signal, 1-bit unsigned
    input  [7:0] a,       // 8-bit unsigned input 
    input  [7:0] b,       // 8-bit unsigned input
    output logic [7:0] out // 8-bit unsigned output
);

    // Implementing the 8-bit 2-to-1 multiplexer
    always @(*) begin
        out = sel ? b : a; // Select output based on sel
    end

endmodule
[DONE]
```