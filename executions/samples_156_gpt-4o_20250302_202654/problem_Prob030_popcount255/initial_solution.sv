module TopModule(
    input [254:0] in,
    output [7:0] out
);

    // Internal signal to hold the population count
    logic [7:0] count;

    // Combinational logic to calculate the population count
    always @(*) begin
        integer i;
        count = 8'b0; // Initialize count to zero
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
    end

    // Assign the calculated count to the output
    assign out = count;

endmodule