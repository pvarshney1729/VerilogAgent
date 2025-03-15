module edge_detector (
    input logic clk,
    input logic rst_n,
    input logic [7:0] data_in,
    output logic edge_detected
);

    logic [7:0] data_reg;

    always @(posedge clk) begin
        if (!rst_n) begin
            data_reg <= 8'b00000000;
        end else begin
            data_reg <= data_in;
        end
    end

    always @(*) begin
        edge_detected = (data_reg != data_in);
    end

endmodule