module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] data_in,
    output logic [31:0] data_out
);

    logic [31:0] prev_data_in;

    always_ff @(posedge clk) begin
        if (reset) begin
            data_out <= 32'b0;
            prev_data_in <= 32'b0;
        end else begin
            data_out <= data_out | (prev_data_in & ~data_in);
            prev_data_in <= data_in;
        end
    end

endmodule