module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    always @(posedge clk) begin
        if (!rst_n) begin
            data_out <= 8'b00000000; // Initialize to zero on reset
        end else begin
            data_out <= data_in; // Pass-through logic
        end
    end

endmodule