module TopModule (
    input  [254:0] in,
    output [7:0]   out
);

    // Internal signal to hold the count of '1's
    logic [7:0] count;
    integer i;

    // Combinational logic to count the number of '1's in the input vector
    always @(*) begin
        count = 8'b0; // Initialize count to zero
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
    end

    // Assign the count to the output
    assign out = count;

endmodule