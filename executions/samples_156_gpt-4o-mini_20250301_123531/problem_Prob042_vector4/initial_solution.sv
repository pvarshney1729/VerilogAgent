```verilog
module TopModule (
    input logic [7:0] data_in,
    output logic [31:0] sign_extended_out
);

assign sign_extended_out = { {24{data_in[7]}}, data_in };

endmodule
```