[BEGIN]
module TopModule(
    input logic [254:0] in,
    output logic [7:0] out
);

    logic [8:0] population_count;

    always @(*) begin
        integer i;
        population_count = 9'b0;
        for (i = 0; i < 255; i = i + 1) begin
            population_count = population_count + in[i];
        end
        out = (population_count > 9'd255) ? 8'd255 : population_count[7:0];
    end

endmodule
[DONE]