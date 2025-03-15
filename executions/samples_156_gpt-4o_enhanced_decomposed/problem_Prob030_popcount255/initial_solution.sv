module TopModule(
    input logic [254:0] in,  // 255-bit input
    output logic [7:0] out   // 8-bit output
);

    // Combinational logic to count the number of '1's in the input vector
    always @(*) begin
        integer i;
        out = 8'd0;  // Initialize the output to zero
        for (i = 0; i < 255; i = i + 1) begin
            if (in[i] == 1'b1) begin
                out = out + 1'b1;  // Increment the count for each '1'
            end
        end
    end

endmodule