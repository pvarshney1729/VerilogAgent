module TopModule(
    input logic [254:0] in,
    output logic [7:0] out
);

    // Combinational logic to calculate the population count
    always_comb begin
        integer i;
        integer count;
        count = 0;
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
        out = count[7:0]; // Assign the lower 8 bits of count to out
    end

endmodule