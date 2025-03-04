module TopModule(
    input [254:0] in,
    output [7:0] out
);

    // Internal logic to count the number of '1's in the input vector
    integer i;
    reg [7:0] count;

    always @(*) begin
        count = 8'b0; // Initialize count to zero
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
    end

    assign out = count;

endmodule