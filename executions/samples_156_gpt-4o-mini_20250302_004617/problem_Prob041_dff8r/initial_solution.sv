module my_module (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] data_reg
);

always @(posedge clk) begin
    if (reset) begin
        data_reg <= 8'b0;
    end else begin
        data_reg <= d;
    end
end

endmodule