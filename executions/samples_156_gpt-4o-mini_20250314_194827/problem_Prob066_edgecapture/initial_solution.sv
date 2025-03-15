module transition_detector (
    input logic clk,
    input logic rst_n,
    input logic [31:0] data_in,
    output logic [31:0] transition_out
);

    logic [31:0] data_reg;

    always @(posedge clk) begin
        if (!rst_n) begin
            data_reg <= 32'b0;
            transition_out <= 32'b0;
        end else begin
            transition_out <= (data_reg & ~data_in);
            data_reg <= data_in;
        end
    end

endmodule