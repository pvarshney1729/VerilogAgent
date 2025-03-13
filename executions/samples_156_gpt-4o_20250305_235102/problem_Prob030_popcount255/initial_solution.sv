module TopModule(
    input [254:0] in,
    output [7:0] out
);

    // Internal signal to hold the population count
    logic [7:0] pop_count;

    // Combinational logic to calculate the population count
    always @(*) begin
        integer i;
        pop_count = 8'b0; // Initialize population count to zero
        for (i = 0; i < 255; i = i + 1) begin
            pop_count = pop_count + in[i];
        end
    end

    // Assign the calculated population count to the output
    assign out = pop_count;

endmodule