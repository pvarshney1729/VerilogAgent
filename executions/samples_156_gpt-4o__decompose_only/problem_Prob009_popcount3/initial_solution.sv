module TopModule(
    input  logic [2:0] in,
    output logic [1:0] out
);

    // Combinational logic to count the number of '1's in the input vector
    always @(*) begin
        out = in[0] + in[1] + in[2];
    end

endmodule