```verilog
module TopModule(
    input logic signed [7:0] in_data,
    output logic [31:0] out_data
);
    assign out_data = {{24{in_data[7]}}, in_data};
endmodule
```