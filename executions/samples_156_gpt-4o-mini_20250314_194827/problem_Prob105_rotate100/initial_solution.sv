module rotation_load (
    input logic clk,
    input logic rst_n,
    input logic ena,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] reg_data;

    always @(posedge clk) begin
        if (!rst_n) begin
            reg_data <= 8'b00000000;
        end else if (ena) begin
            reg_data <= {reg_data[6:0], reg_data[7]}; // Left rotation
        end
    end

    assign data_out = reg_data;

endmodule