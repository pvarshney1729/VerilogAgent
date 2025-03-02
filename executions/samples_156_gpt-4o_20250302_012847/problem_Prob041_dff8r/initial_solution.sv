module revised_module (
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    always_ff @(posedge clk) begin
        if (reset) begin
            data_out <= 8'b0;
        end else begin
            data_out <= data_in;
        end
    end

endmodule