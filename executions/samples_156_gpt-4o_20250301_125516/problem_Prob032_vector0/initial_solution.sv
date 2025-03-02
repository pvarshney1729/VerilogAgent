```verilog
module TopModule (
    input logic [2:0] vec,  // A 3-bit unsigned input vector
    output logic [2:0] outv, // A 3-bit unsigned output vector
    output logic o2,         // A 1-bit output corresponding to vec[2]
    output logic o1,         // A 1-bit output corresponding to vec[1]
    output logic o0          // A 1-bit output corresponding to vec[0]
);

    // Combinational logic to directly mirror the input vector to the output vector
    assign outv = vec;

    // Combinational logic to assign individual bits of the input vector to outputs
    assign o2 = vec[2];
    assign o1 = vec[1];
    assign o0 = vec[0];

endmodule
```