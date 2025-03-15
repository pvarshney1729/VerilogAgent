module TopModule(
    input logic [1023:0] in,
    input logic [7:0] sel,
    output logic [3:0] out
);

    always @(*) begin
        // Calculate the starting bit position for the selected 4-bit group
        integer start_bit;
        start_bit = sel * 4;
        
        // Assign the selected 4-bit group to the output
        out = in[start_bit +: 4];
    end

endmodule