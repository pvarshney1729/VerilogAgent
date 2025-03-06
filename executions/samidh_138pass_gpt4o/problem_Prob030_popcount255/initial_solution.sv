```verilog
[BEGIN]
module TopModule (
    input  logic [254:0] in,  // 255-bit unsigned input vector
    output logic [7:0]   out  // 8-bit unsigned output vector
);

    // Combinational logic for population count
    always @(*) begin
        out = 8'b0;  // Initialize output to zero
        for (int i = 0; i < 255; i++) begin
            out = out + in[i];  // Sum the bits
        end
    end

endmodule
[DONE]
```