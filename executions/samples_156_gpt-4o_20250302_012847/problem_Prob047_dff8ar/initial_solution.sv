module revised_module (
    input logic clk,
    input logic async_reset_n,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    always_ff @(posedge clk or negedge async_reset_n) begin
        if (!async_reset_n)
            data_out <= 8'b0;
        else
            data_out <= data_in;
    end

endmodule