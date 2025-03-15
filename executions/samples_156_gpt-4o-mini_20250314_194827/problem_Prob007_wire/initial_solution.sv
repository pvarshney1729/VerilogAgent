module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] data_reg;

    always @(posedge clk) begin
        if (!rst_n) begin
            data_reg <= 8'b0;
        end else begin
            data_reg <= data_in;
        end
    end

    assign data_out = data_reg;

endmodule