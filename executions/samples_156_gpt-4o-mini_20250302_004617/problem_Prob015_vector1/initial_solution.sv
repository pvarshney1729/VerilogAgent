module combinational_logic (
    input logic [15:0] data_in,
    input logic clk,
    input logic rst_n,
    output logic [15:0] data_out
);

    always @(*) begin
        if (!rst_n) begin
            data_out = 16'b0;
        end else begin
            // Example combinational logic operation
            data_out = data_in ^ 16'hFFFF; // Invert the input for demonstration
        end
    end

endmodule