module TopModule(
    input  logic [254:0] in,
    output logic [7:0]   out
);

    always @(*) begin
        integer i;
        out = 8'b0; // Initialize the output to zero
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i]; // Count the number of '1's
        end
    end

endmodule