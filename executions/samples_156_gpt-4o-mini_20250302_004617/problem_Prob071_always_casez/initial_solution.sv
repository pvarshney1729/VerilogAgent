module priority_encoder (
    input logic [7:0] in,
    input logic clk,
    input logic rst,
    output logic [2:0] pos
);

always @(*) begin
    if (rst) begin
        pos = 3'b000;
    end else begin
        casez (in)
            8'b1??????? : pos = 3'd7;
            8'b01?????? : pos = 3'd6;
            8'b001????? : pos = 3'd5;
            8'b0001???? : pos = 3'd4;
            8'b00001??? : pos = 3'd3;
            8'b000001?? : pos = 3'd2;
            8'b0000001? : pos = 3'd1;
            8'b00000001 : pos = 3'd0;
            default: pos = 3'b000; // No bits are high
        endcase
    end
end

endmodule