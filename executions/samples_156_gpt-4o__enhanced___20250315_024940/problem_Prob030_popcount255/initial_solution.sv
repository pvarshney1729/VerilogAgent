module TopModule (
    input  logic [254:0] in,
    output logic [7:0] out
);

    always @(*) begin
        // Initialize the count to zero
        logic [7:0] count = 8'b00000000;

        // Iterate through each bit of the input vector to count the number of '1's
        for (integer i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end

        // Assign the computed count to the output
        out = count;
    end

endmodule