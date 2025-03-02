module mux_256_to_1 (
    input logic [255:0] data_in,
    input logic [7:0] select,
    input logic clk,
    input logic reset,
    output logic data_out
);

    always_ff @(posedge clk) begin
        if (reset) begin
            data_out <= 1'b0;
        end else begin
            data_out <= data_in[select];
        end
    end

endmodule