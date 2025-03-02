module population_count (
    input logic [15:0] data_in,
    output logic [4:0] count
);

always @(*) begin
    count = 5'b0; // Initialize count to zero
    for (int i = 0; i < 16; i++) begin
        count = count + data_in[i]; // Sum the bits
    end
end

endmodule