```verilog
module TopModule(
    input  [7:0]  in,
    output [31:0] out
);

    // Sign extension using replication and concatenation
    assign out = {{24{in[7]}}, in};

endmodule
```