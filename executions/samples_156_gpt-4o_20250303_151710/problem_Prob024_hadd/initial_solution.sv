```verilog
module TopModule(
    input wire a,
    input wire b,
    output wire sum,
    output wire cout
);

    // Combinational logic for half adder
    assign sum = a ^ b;  // XOR operation for sum
    assign cout = a & b; // AND operation for carry-out

endmodule
```