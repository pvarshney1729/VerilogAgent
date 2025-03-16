```verilog
module TopModule (
    input  logic [15:0] in_data,
    output logic [7:0]  out_hi,
    output logic [7:0]  out_lo
);

assign out_hi = in_data[15:8];
assign out_lo = in_data[7:0];

endmodule
```