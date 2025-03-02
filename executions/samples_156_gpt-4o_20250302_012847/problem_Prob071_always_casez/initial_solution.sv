module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] data_in,
    output logic [2:0] first_one_position,
    output logic found
);

    always @(*) begin
        found = 1'b0;
        first_one_position = 3'b000;
        for (int i = 0; i < 8; i++) begin
            if (data_in[i] == 1'b1 && found == 1'b0) begin
                found = 1'b1;
                first_one_position = i[2:0];
            end
        end
    end

endmodule