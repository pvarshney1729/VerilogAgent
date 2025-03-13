```
[BEGIN]
module TopModule (
    input  logic [31:0] in_data,
    output logic [31:0] out_data
);

    // Combinational logic for byte reversal
    always @(*) begin
        out_data[31:24] = in_data[7:0];   // byte0 becomes byte3
        out_data[23:16] = in_data[15:8];  // byte1 becomes byte2
        out_data[15:8]  = in_data[23:16]; // byte2 becomes byte1
        out_data[7:0]   = in_data[31:24]; // byte3 becomes byte0
    end

endmodule
[DONE]
```