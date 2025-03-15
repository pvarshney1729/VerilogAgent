module TopModule (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] reg_data;

    always @(posedge clk) begin
        if (!rst_n) begin
            reg_data <= 8'b00000000; // Asynchronous reset to zero
        end else if (load) begin
            reg_data <= data_in; // Load data when load signal is high
        end
    end

    assign data_out = reg_data; // Output the current value of the register

endmodule