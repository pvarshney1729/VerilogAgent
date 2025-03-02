module shift_count_register (
    input logic clk,
    input logic reset_n,
    input logic shift_en,
    input logic count_en,
    output logic [3:0] data_out
);
    logic [3:0] reg_data;

    always @(*) begin
        if (!reset_n) begin
            reg_data = 4'b0000;
        end else if (shift_en && !count_en) begin
            reg_data = {reg_data[2:0], 1'b1}; // Shift right and insert 1
        end else if (!shift_en && count_en) begin
            reg_data = reg_data + 1'b1; // Increment
        end else begin
            reg_data = reg_data; // Hold value
        end
    end

    assign data_out = reg_data;

endmodule