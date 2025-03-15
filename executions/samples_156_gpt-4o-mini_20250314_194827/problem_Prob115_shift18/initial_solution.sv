module shift_register (
    input logic clk,
    input logic reset,
    input logic load,
    input logic shift_left,
    input logic [5:0] shift_amount,
    input logic [63:0] data_in,
    output logic [63:0] data_out
);

    logic [63:0] reg_data;

    always @(*) begin
        if (reset) begin
            reg_data = 64'b0;
        end else if (load) begin
            reg_data = data_in;
        end else begin
            if (shift_left) begin
                reg_data = reg_data << shift_amount;
            end else begin
                reg_data = reg_data >> shift_amount; // Arithmetic right shift
            end
        end
    end

    assign data_out = reg_data;

endmodule