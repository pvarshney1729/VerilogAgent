module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] data_in,
    output logic [7:0] edge_detected
);

    logic [7:0] data_reg;
    logic [7:0] data_prev;

    always @(posedge clk) begin
        if (!rst_n) begin
            data_reg <= 8'b00000000;
            data_prev <= 8'b00000000;
        end else begin
            data_prev <= data_reg;
            data_reg <= data_in;
        end
    end

    always @(*) begin
        edge_detected = data_reg ^ data_prev;
    end

endmodule