module TopModule (
    input logic [254:0] data_in,
    output logic [7:0] population_count
);

    always @(*) begin
        population_count = 0;
        for (int i = 0; i < 255; i++) begin
            population_count = population_count + data_in[i];
        end
    end

endmodule