module TopModule (
    input logic clk,
    input logic reset,
    input logic load,
    input logic shift,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] shift_reg;

    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 8'b00000000;
        end else if (load) begin
            shift_reg <= data_in;
        end else if (shift) begin
            shift_reg <= {shift_reg[6:0], 1'b0}; // Shift left and fill with 0
        end
    end

    assign data_out = shift_reg;

endmodule