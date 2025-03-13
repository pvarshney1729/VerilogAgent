```verilog
[BEGIN]
module TopModule (
    input logic [2:0] vec,
    output logic [2:0] outv,
    output logic o2,
    output logic o1,
    output logic o0
);

    // Assign the 3-bit vector to the output
    assign outv = vec;

    // Split the vector into individual bits
    always @(*) begin
        o0 = vec[0]; // Assign bit 0
        o1 = vec[1]; // Assign bit 1
        o2 = vec[2]; // Assign bit 2
    end

endmodule
[DONE]
```