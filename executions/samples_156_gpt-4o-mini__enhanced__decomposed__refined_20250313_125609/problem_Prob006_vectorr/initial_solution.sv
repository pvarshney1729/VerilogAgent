```
[BEGIN]
module TopModule (
    input logic [7:0] input_data, // 8-bit input signal
    output logic [7:0] output_data  // 8-bit output signal
);

always @(*) begin
    // Bit Reversal Logic
    output_data = {input_data[7], input_data[6], input_data[5], input_data[4], 
                   input_data[3], input_data[2], input_data[1], input_data[0]};
end

endmodule
[DONE]
```