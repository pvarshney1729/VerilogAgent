module count_ones (
    input logic [2:0] data_in,
    input logic clk,
    input logic rst_n,
    output logic [1:0] count_out
);

always @(*) begin
    count_out = 2'b00; // Initialize count
    if (data_in[0] == 1'b1) count_out = count_out + 2'b01;
    if (data_in[1] == 1'b1) count_out = count_out + 2'b01;
    if (data_in[2] == 1'b1) count_out = count_out + 2'b01;
end

endmodule