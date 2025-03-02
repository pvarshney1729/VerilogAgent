module rotation_register (
    input logic clk,
    input logic rst_n,
    input logic [99:0] data_in,
    input logic [1:0] rotate_dir,
    output logic [99:0] data_out
);

    logic [99:0] reg_data;

    always @(posedge clk) begin
        if (!rst_n) begin
            reg_data <= 100'b0;
        end else begin
            case (rotate_dir)
                2'b00: reg_data <= data_in; // Load data
                2'b01: reg_data <= {reg_data[98:0], reg_data[99]}; // Rotate right
                2'b10: reg_data <= {reg_data[0], reg_data[99:1]}; // Rotate left
                default: reg_data <= reg_data; // No operation
            endcase
        end
    end

    assign data_out = reg_data;

endmodule