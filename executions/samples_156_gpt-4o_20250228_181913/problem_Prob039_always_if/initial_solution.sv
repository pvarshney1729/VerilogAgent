```verilog
module TopModule (
    input  wire a,         // 1-bit input signal
    input  wire b,         // 1-bit input signal
    input  wire sel_b1,    // 1-bit selection control
    input  wire sel_b2,    // 1-bit selection control
    output wire out_assign,// 1-bit output from assign-based mux
    output reg  out_always // 1-bit output from procedural-based mux
);

    // Assign-based implementation
    assign out_assign = (sel_b1 & sel_b2) ? b : a;

    // Procedural-based implementation
    always @(*) begin
        if (sel_b1 & sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule
```