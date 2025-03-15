module data_handler (
    input logic clk,
    input logic rst_n,
    input logic [15:0] data_in,
    input logic [1:0] byte_en,
    output logic [15:0] data_out
);

    logic [15:0] data_reg;

    always @(posedge clk) begin
        if (!rst_n) begin
            data_reg <= 16'b0;
        end else begin
            if (byte_en[0]) begin
                data_reg[7:0] <= data_in[7:0];
            end
            if (byte_en[1]) begin
                data_reg[15:8] <= data_in[15:8];
            end
        end
    end

    assign data_out = data_reg;

endmodule