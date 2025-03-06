```verilog
[BEGIN]
module TopModule (
    input        sel,     // 1-bit selection input: 0 selects 'a', 1 selects 'b'
    input  [7:0] a,       // 8-bit input data 'a'
    input  [7:0] b,       // 8-bit input data 'b'
    output logic [7:0] out // 8-bit output data
);

    // Combinational Logic Behavior
    always @(*) begin
        if (sel == 1'b0) begin
            out = a; // If 'sel' is 0, output 'out' will be equal to input 'a'.
        end else begin
            out = b; // If 'sel' is 1, output 'out' will be equal to input 'b'.
        end
    end

endmodule
[DONE]
```