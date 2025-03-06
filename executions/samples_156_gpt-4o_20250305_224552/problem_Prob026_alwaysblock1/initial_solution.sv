```verilog
module TopModule (
    input wire a,       // Input signal 'a'
    input wire b,       // Input signal 'b'
    output wire out_assign,       // Output for assign statement
    output reg out_alwaysblock    // Output for always block
);

// Assign statement for AND operation
assign out_assign = a & b;

// Always block for AND operation
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule
```