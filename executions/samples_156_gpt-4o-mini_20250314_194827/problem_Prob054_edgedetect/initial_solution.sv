module edge_detector (
    input logic clk,
    input logic rst_n,
    input logic [7:0] data_in,
    output logic [7:0] edge_out
);

    logic [7:0] data_reg;
    logic [7:0] data_prev;

    always @(*) begin
        edge_out = data_reg ^ data_prev; // XOR for edge detection
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            data_reg <= 8'b00000000; // Initialize to zero on reset
            data_prev <= 8'b00000000; // Initialize to zero on reset
        end else begin
            data_prev <= data_reg; // Store previous data
            data_reg <= data_in; // Update current data
        end
    end

endmodule