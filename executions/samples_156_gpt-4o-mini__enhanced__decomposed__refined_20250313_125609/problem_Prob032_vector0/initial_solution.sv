```
[BEGIN]
module TopModule (
    input logic [2:0] vec,     // 3-bit input vector (unsigned)
    output logic [2:0] outv,   // 3-bit output vector (unsigned)
    output logic o0,           // 1-bit output corresponding to vec[0]
    output logic o1,           // 1-bit output corresponding to vec[1]
    output logic o2            // 1-bit output corresponding to vec[2]
);

always @(*) begin
    outv = vec;       // Output the same 3-bit vector
    o0 = vec[0];      // Assign o0 to the LSB of vec
    o1 = vec[1];      // Assign o1 to the middle bit of vec
    o2 = vec[2];      // Assign o2 to the MSB of vec
end

endmodule
[DONE]
```