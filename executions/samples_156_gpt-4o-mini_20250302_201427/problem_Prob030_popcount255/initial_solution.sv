module TopModule (
    input  logic [254:0] in,
    output logic [7:0]  out
);
    assign out = population_count(in);

    function logic [7:0] population_count(input logic [254:0] vec);
        integer i;
        begin
            population_count = 8'b0;
            for (i = 0; i <= 254; i = i + 1) begin
                population_count = population_count + vec[i];
            end
        end
    endfunction
endmodule