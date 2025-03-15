module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [3:0] data_in,
    output logic [3:0] data_out
);

    logic [3:0] reg_data;

    // Synchronous reset and initialization
    always @(posedge clk) begin
        if (!rst_n) begin
            reg_data <= 4'b0000; // Initialize to zero on reset
        end else begin
            reg_data <= data_in; // Capture input data
        end
    end

    // Output assignment
    assign data_out = reg_data;

endmodule