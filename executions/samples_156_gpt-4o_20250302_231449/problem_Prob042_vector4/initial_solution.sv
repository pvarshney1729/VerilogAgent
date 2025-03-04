```verilog
module TopModule(
    input [7:0] input_value,
    output [31:0] output_value
);

    // Sign-extension logic
    assign output_value = {{24{input_value[7]}}, input_value};

endmodule
```