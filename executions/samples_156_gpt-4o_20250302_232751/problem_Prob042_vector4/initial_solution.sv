module TopModule (
    input  wire signed [7:0]  in_data,  // 8-bit signed input
    output wire signed [31:0] out_data  // 32-bit signed output
);

    // Perform sign extension from 8-bit to 32-bit
    assign out_data = {{24{in_data[7]}}, in_data};

endmodule