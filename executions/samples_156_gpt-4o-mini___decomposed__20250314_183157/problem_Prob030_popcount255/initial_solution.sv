module TopModule (
    input  logic [254:0] in,
    output logic [7:0] out
);
    logic [7:0] population_count;
    integer i;

    always @(*) begin
        population_count = 8'b0; // Initialize output
        for (i = 0; i < 255; i = i + 1) begin
            population_count = population_count + in[i]; // Count '1's
        end
    end

    assign out = population_count;

endmodule